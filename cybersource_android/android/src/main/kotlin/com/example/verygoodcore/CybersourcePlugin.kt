package com.example.verygoodcore

import androidx.annotation.NonNull

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class CybersourcePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "cybersource_android")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            Constants.MethodCalls.GetPlatformName.NAME -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            Constants.MethodCalls.GetSessionId.NAME -> {
                val orderId =
                    call.argument<String?>(Constants.MethodCalls.GetSessionId.Params.ORDER_ID)
                val orgId = call.argument<String?>(Constants.MethodCalls.GetSessionId.Params.ORG_ID)
                val fingerprintServerUrl =
                    call.argument<String?>(Constants.MethodCalls.GetSessionId.Params.FINGERPRINT_SERVER_URL)
                val merchantId =
                    call.argument<String?>(Constants.MethodCalls.GetSessionId.Params.MERCHANT_ID)
                val sessionId = getCybersourceSessionId(
                    orderId = orderId,
                    orgId = orgId,
                    fingerprintServerUrl = fingerprintServerUrl,
                    merchantId = merchantId,
                )
                result.success(sessionId)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getCybersourceSessionId(
        orderId: String?,
        orgId: String?,
        fingerprintServerUrl: String?,
        merchantId: String?
    ): String {
        if (orderId == null || orgId == null || fingerprintServerUrl == null || merchantId == null) {
            throw IllegalArgumentException("Missing required arguments for getCybersourceSessionId")
        }
        val fraudApi = CybersourceAntiFraudApiImpl(
            context = context,
            orgId = orgId,
            fingerprintServerUrl = fingerprintServerUrl,
            merchantId = merchantId
        )
        return fraudApi.getSessionId(orderId)
    }
}