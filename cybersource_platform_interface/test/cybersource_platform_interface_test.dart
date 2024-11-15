import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

class CybersourceMock extends CybersourcePlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('CybersourcePlatformInterface', () {
    late CybersourcePlatform cybersourcePlatform;

    setUp(() {
      cybersourcePlatform = CybersourceMock();
      CybersourcePlatform.instance = cybersourcePlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await CybersourcePlatform.instance.getPlatformName(),
          equals(CybersourceMock.mockPlatformName),
        );
      });
    });
  });
}
