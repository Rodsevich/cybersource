package com.example.verygoodcore

import android.content.Context
import android.util.Log
import com.threatmetrix.TrustDefender.RL.TMXConfig
import com.threatmetrix.TrustDefender.RL.TMXProfiling
import com.threatmetrix.TrustDefender.RL.TMXProfilingConnections.TMXProfilingConnections
import com.threatmetrix.TrustDefender.RL.TMXProfilingOptions
import java.util.concurrent.TimeUnit


class CybersourceAntiFraudApiImpl(
    private val context: Context,
    private val orgId: String,
    private val fingerprintServerUrl: String,
    private val merchantId: String,
    private val tmxProfiling: TMXProfiling = TMXProfiling.getInstance(),
) : CybersourceAntiFraudApi {

    init {
        // Initialize the SDK
        val profilingConnections =
            TMXProfilingConnections().setConnectionTimeout(20, TimeUnit.SECONDS).setRetryTimes(3)

        val config = TMXConfig()
            .setOrgId(orgId)
            .setFPServer(fingerprintServerUrl)
            .setContext(context)
            .setProfilingConnections(profilingConnections)

        // Set the profiling connections to the config
        config.setProfilingConnections(profilingConnections)

        // Initialize the SDK
        tmxProfiling.init(config)

    }

    override fun getSessionId(orderId: String): String {
        val options = TMXProfilingOptions().setCustomAttributes(null)
        // Set the session ID
        val sessionId = merchantId + orderId
        options.setSessionID(sessionId)
        return tmxProfiling.profile(options) { result ->
            Log.i(
                "PROFILE COMPLETED", "Profile completed with: " + result.sessionID + " - "
                        + result.status.desc
            )
        }.sessionID
    }


}
