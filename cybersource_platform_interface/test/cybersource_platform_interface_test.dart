import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

class CybersourceMock extends CybersourcePlatform {
  static const mockPlatformName = 'Mock';
  static const mockSessionId = 'MockSessionId';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;

  @override
  Future<String?> getSessionId(
    String orderId,
    String orgId,
    String fingerprintServerUrl,
    String merchantId,
  ) async =>
      mockSessionId;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('CybersourcePlatformInterface', () {
    late CybersourcePlatform cybersourcePlatform;

    setUp(() {
      cybersourcePlatform = CybersourceMock();
      CybersourcePlatform.instance = cybersourcePlatform;
    });

    group('getSessionId', () {
      test('returns correct name', () async {
        expect(
          await CybersourcePlatform.instance.getSessionId(
            'mockOrderId',
            'mockOrgId',
            'mockFingerPrintUrl',
            'mockMerchantId',
          ),
          equals(CybersourceMock.mockSessionId),
        );
      });
    });
  });
}
