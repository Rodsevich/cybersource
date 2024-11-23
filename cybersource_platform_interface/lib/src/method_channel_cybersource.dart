import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';

/// An implementation of [CybersourcePlatform] that uses method channels.
class MethodChannelCybersource extends CybersourcePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cybersource');

  @override
  Future<String?> getSessionId(
    String orderId,
    String orgId,
    String fingerprintServerUrl,
    String merchantId,
  ) {
    return methodChannel.invokeMethod<String>('getSessionId');
  }
}
