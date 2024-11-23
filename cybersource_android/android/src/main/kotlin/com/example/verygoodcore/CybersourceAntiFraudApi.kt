package com.example.verygoodcore

interface CybersourceAntiFraudApi {
    fun getSessionId(orderId: String): String
}
