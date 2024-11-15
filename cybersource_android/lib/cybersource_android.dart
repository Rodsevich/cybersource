import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The Android implementation of [CybersourcePlatform].
class CybersourceAndroid extends CybersourcePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cybersource_android');

  /// Registers this class as the default instance of [CybersourcePlatform]
  static void registerWith() {
    CybersourcePlatform.instance = CybersourceAndroid();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
