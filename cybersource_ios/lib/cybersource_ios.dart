import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The iOS implementation of [CybersourcePlatform].
class CybersourceIOS extends CybersourcePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cybersource_ios');

  /// Registers this class as the default instance of [CybersourcePlatform]
  static void registerWith() {
    CybersourcePlatform.instance = CybersourceIOS();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Future<String?> getSessionId(
    String orderId,
    String orgId,
    String fingerprintServerUrl,
    String merchantId,
  ) {
    // TODO: implement getSessionId
    throw UnimplementedError();
  }
}
