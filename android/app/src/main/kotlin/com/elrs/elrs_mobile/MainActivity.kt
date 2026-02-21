package com.elrs.elrs_mobile

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
        val request = NetworkRequest.Builder()
            .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
            .build()

        connectivityManager?.requestNetwork(request, object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                super.onAvailable(network)
                try {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        connectivityManager?.bindProcessToNetwork(network)
                    } else {
                        ConnectivityManager.setProcessDefaultNetwork(network)
                    }
                    boundNetwork = network
                    runOnUiThread { result.success(true) }
                } catch (e: Exception) {
                    runOnUiThread { result.error("BIND_FAILED", e.message, null) }
                }
            }

            override fun onUnavailable() {
                super.onUnavailable()
                runOnUiThread { result.error("UNAVAILABLE", "WiFi network not available", null) }
            }
        })
    }

    private fun unbindProcess(result: MethodChannel.Result) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                connectivityManager?.bindProcessToNetwork(null)
            } else {
                ConnectivityManager.setProcessDefaultNetwork(null)
            }
            boundNetwork = null
            result.success(true)
        } catch (e: Exception) {
            result.error("UNBIND_FAILED", e.message, null)
        }
    }
}
