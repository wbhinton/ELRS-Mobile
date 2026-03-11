package io.datarx.elrsmobile

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "org.expresslrs.elrs_mobile/network"
    private var connectivityManager: ConnectivityManager? = null
    private var boundNetwork: Network? = null
    private var networkCallback: ConnectivityManager.NetworkCallback? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "bindProcessToWiFi" -> {
                    bindProcessToWiFi(result)
                }
                "unbindProcess" -> {
                    unbindProcess(result)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun bindProcessToWiFi(result: MethodChannel.Result) {
        val safeResult = SafeResult(result)
        // Unregister any existing callback first
        networkCallback?.let {
            try {
                connectivityManager?.unregisterNetworkCallback(it)
            } catch (e: Exception) {
                // Ignore failure to unregister
            }
        }

        val request = NetworkRequest.Builder()
            .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
            // CRITICAL: Remove NET_CAPABILITY_INTERNET so we can bind to ELRS hotspots
            // that don't provide internet access.
            .removeCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .build()

        val callback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                super.onAvailable(network)
                try {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        connectivityManager?.bindProcessToNetwork(network)
                    } else {
                        @Suppress("DEPRECATION")
                        ConnectivityManager.setProcessDefaultNetwork(network)
                    }
                    boundNetwork = network
                    safeResult.success(true)
                } catch (e: Exception) {
                    safeResult.error("BIND_FAILED", e.message, null)
                }
            }

            override fun onUnavailable() {
                super.onUnavailable()
                safeResult.error("UNAVAILABLE", "WiFi network not available", null)
            }
        }

        networkCallback = callback
        connectivityManager?.requestNetwork(request, callback)
    }

    private fun unbindProcess(result: MethodChannel.Result) {
        val safeResult = SafeResult(result)
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                connectivityManager?.bindProcessToNetwork(null)
            } else {
                @Suppress("DEPRECATION")
                ConnectivityManager.setProcessDefaultNetwork(null)
            }
            
            networkCallback?.let {
                try {
                    connectivityManager?.unregisterNetworkCallback(it)
                } catch (e: Exception) {
                    // Ignore
                }
                networkCallback = null
            }
            
            boundNetwork = null
            safeResult.success(true)
        } catch (e: Exception) {
            safeResult.error("UNBIND_FAILED", e.message, null)
        }
    }

    /**
     * A wrapper for MethodChannel.Result that ensures each result is only called once.
     * This prevents "java.lang.IllegalStateException: Reply already submitted" errors
     * if a callback (like ConnectivityManager.NetworkCallback) triggers multiple times.
     */
    private class SafeResult(private val result: MethodChannel.Result) : MethodChannel.Result {
        private var hasReplied = false

        override fun success(any: Any?) {
            runOnUiThread {
                if (!hasReplied) {
                    hasReplied = true
                    result.success(any)
                }
            }
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
            runOnUiThread {
                if (!hasReplied) {
                    hasReplied = true
                    result.error(errorCode, errorMessage, errorDetails)
                }
            }
        }

        override fun notImplemented() {
            runOnUiThread {
                if (!hasReplied) {
                    hasReplied = true
                    result.notImplemented()
                }
            }
        }

        private fun runOnUiThread(action: () -> Unit) {
            if (android.os.Looper.myLooper() == android.os.Looper.getMainLooper()) {
                action()
            } else {
                android.os.Handler(android.os.Looper.getMainLooper()).post(action)
            }
        }
    }
}
