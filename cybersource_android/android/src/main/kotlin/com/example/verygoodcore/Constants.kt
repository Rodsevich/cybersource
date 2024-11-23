package com.example.verygoodcore

object Constants {

    interface MethodCalls {

        interface GetSessionId {
            companion object {
                const val NAME = "getSessionId"
            }

            interface Params {
                companion object {
                    const val ORDER_ID = "orderId"
                    const val ORG_ID = "orgId"
                    const val FINGERPRINT_SERVER_URL = "fingerprintServerUrl"
                    const val MERCHANT_ID = "merchantId"
                }
            }
        }

    }

}
