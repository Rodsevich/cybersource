import 'package:cybersource/cybersource.dart';
import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCybersourcePlatform extends Mock
    with MockPlatformInterfaceMixin
    implements CybersourcePlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Cybersource', () {
    late CybersourcePlatform cybersourcePlatform;

    setUp(() {
      cybersourcePlatform = MockCybersourcePlatform();
      CybersourcePlatform.instance = cybersourcePlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => cybersourcePlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => cybersourcePlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
