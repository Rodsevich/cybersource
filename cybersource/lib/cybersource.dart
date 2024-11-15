import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';

CybersourcePlatform get _platform => CybersourcePlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}
