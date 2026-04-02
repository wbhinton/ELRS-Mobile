package io.datarx.elrsmobile

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiManager
import android.os.Build
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.activity.enableEdgeToEdge
import android.os.Bundle

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "org.expresslrs.elrs_mobile/network"
    private var connectivityManager: ConnectivityManager? = null
    private var boundNetwork: Network? = null
    private var networkCallback: ConnectivityManager.NetworkCallback? = null

    private var multicastLock: WifiManager.MulticastLock? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Enable edge-to-edge display
        enableEdgeToEdge()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        
        val wifi = getSystemService(Context.WIFI_SERVICE) as android.net.wifi.WifiManager
        multicastLock = wifi.createMulticastLock("elrs_mobile_multicast_lock").apply {
            setReferenceCounted(false)
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "bindProcessToWiFi" -> {
                    bindProcessToWiFi(result)
                }
                "unbindProcess" -> {
                    unbindProcess(result)
                }
                "acquireMulticastLock" -> {
                    try {
                        multicastLock?.acquire()
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("LOCK_FAILED", e.message, null)
                    }
                }
                "releaseMulticastLock" -> {
                    try {
                        if (multicastLock?.isHeld == true) {
                            multicastLock?.release()
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("RELEASE_FAILED", e.message, null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun bindProcessToWiFi(result: MethodChannel.Result) {
        val safeResult = SafeResult(result)
        
        // 0. Pre-Flight Check: Are we already safely bound?
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val currentBound = connectivityManager?.boundNetworkForProcess
            if (currentBound != null) {
                val caps = connectivityManager?.getNetworkCapabilities(currentBound)
                if (caps?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true) {
                    println("NATIVE: Already natively bound to an active WiFi network. Bypassing request loop.")
                    safeResult.success(true)
                    return
                }
            }
        }

        // 2. Unregister any existing callback
        networkCallback?.let {
            try {
                connectivityManager?.unregisterNetworkCallback(it)
            } catch (e: Exception) {}
        }

        // Log all available networks for debugging
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val networks = connectivityManager?.allNetworks ?: emptyArray()
            println("NATIVE: Scanning ${networks.size} networks...")
            for (network in networks) {
                val caps = connectivityManager?.getNetworkCapabilities(network)
                val isWifi = caps?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true
                val hasInternet = caps?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true
                val isValidated = caps?.hasCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED) == true
                println("NATIVE:   Network $network: WiFi=$isWifi Internet=$hasInternet Validated=$isValidated")
            }
            
            // Log active network
            val activeNetwork = connectivityManager?.activeNetwork
            if (activeNetwork != null) {
                val activeCaps = connectivityManager?.getNetworkCapabilities(activeNetwork)
                val activeIsWifi = activeCaps?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true
                val activeHasInternet = activeCaps?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true
                println("NATIVE: Active network: $activeNetwork (WiFi=$activeIsWifi Internet=$activeHasInternet)")
            } else {
                println("NATIVE: No active network!")
            }
        }

        // 2. Try to get the active network first
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val activeNetwork = connectivityManager?.activeNetwork
            if (activeNetwork != null) {
                val caps = connectivityManager?.getNetworkCapabilities(activeNetwork)
                if (caps?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true) {
                    try {
                        connectivityManager?.bindProcessToNetwork(activeNetwork)
                        boundNetwork = activeNetwork
                        println("NATIVE: Bound to active network $activeNetwork")
                        safeResult.success(true)
                        return
                    } catch (e: Exception) {
                        println("NATIVE: Failed to bind to active network: ${e.message}")
                    }
                } else {
                    println("NATIVE: Active network is not WiFi, trying other networks...")
                }
            }
        }

        // 3. Try to find an ALREADY connected WiFi network in allNetworks
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val networks = connectivityManager?.allNetworks ?: emptyArray()
            for (network in networks) {
                val caps = connectivityManager?.getNetworkCapabilities(network)
                // Accept WiFi with or without internet - ELRS devices have no internet
                if (caps?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true) {
                    try {
                        connectivityManager?.bindProcessToNetwork(network)
                        boundNetwork = network
                        println("NATIVE: Found existing WiFi $network, bound process.")
                        safeResult.success(true)
                        return // Success!
                    } catch (e: Exception) {
                        println("NATIVE: Failed to bind to existing network: ${e.message}")
                    }
                }
            }
        }

        // 5. If no existing network found, forcefully request it
        println("NATIVE: Requesting WiFi route from Android OS...")
        val request = NetworkRequest.Builder()
            .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
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
                    println("NATIVE: Network successfully granted by OS: $network, process bound.")
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
