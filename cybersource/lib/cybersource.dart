import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';

CybersourcePlatform get _platform => CybersourcePlatform.instance;

/// Returns the session ID for the given order ID, organization ID, and fingerprint server URL.
Future<String> getSessionId({
  required String orderId,
  required String orgId,
  required String fingerprintServerUrl,
  required String merchantId,
}) async {
  final sessionId = await _platform.getSessionId(
    orderId,
    orgId,
    fingerprintServerUrl,
    merchantId,
  );
  if (sessionId == null) throw Exception('Unable to get session ID.');
  return sessionId;
}
