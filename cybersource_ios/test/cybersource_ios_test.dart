import 'package:cybersource_ios/cybersource_ios.dart';
import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CybersourceIOS', () {
    const kPlatformName = 'iOS';
    late CybersourceIOS cybersource;
    late List<MethodCall> log;

    setUp(() async {
      cybersource = CybersourceIOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(cybersource.methodChannel, (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      CybersourceIOS.registerWith();
      expect(CybersourcePlatform.instance, isA<CybersourceIOS>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await cybersource.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
