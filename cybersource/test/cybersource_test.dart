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

    group('getSessionId', () {
      const sessionId = '__sessionId__';
      const orderId = '__orderId__';
      const orgId = '__orgId__';
      const fingerPrintUrl = '__fingerPrintUrl__';
      const merchantId = '__merchantId__';

      test('returns correct sessionId', () async {
        when(
          () => cybersourcePlatform.getSessionId(
            any(),
            any(),
            any(),
            any(),
          ),
        ).thenAnswer((_) async => sessionId);

        final actualPlatformName = await getSessionId(
          orgId: orderId,
          orderId: orgId,
          fingerprintServerUrl: fingerPrintUrl,
          merchantId: merchantId,
        );
        expect(actualPlatformName, equals(sessionId));
      });

      test('throws exception when session id is null', () async {
        when(
          () => cybersourcePlatform.getSessionId(
            any(),
            any(),
            any(),
            any(),
          ),
        ).thenAnswer((_) async => null);

        expect(
          getSessionId(
            orgId: orderId,
            orderId: orgId,
            fingerprintServerUrl: fingerPrintUrl,
            merchantId: merchantId,
          ),
          throwsException,
        );
      });
    });
  });
}
