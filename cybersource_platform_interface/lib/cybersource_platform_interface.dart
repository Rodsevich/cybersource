import 'package:cybersource_platform_interface/src/method_channel_cybersource.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of cybersource must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `Cybersource`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [CybersourcePlatform] methods.
abstract class CybersourcePlatform extends PlatformInterface {
  /// Constructs a CybersourcePlatform.
  CybersourcePlatform() : super(token: _token);

  static final Object _token = Object();

  static CybersourcePlatform _instance = MethodChannelCybersource();

  /// The default instance of [CybersourcePlatform] to use.
  ///
  /// Defaults to [MethodChannelCybersource].
  static CybersourcePlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [CybersourcePlatform] when they register themselves.
  static set instance(CybersourcePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the Cybersource session id.
  Future<String?> getSessionId(
    String orderId,
    String orgId,
    String fingerprintServerUrl,
    String merchantId,
  );

// Add your platform-specific methods here
}
