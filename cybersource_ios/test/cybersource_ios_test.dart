import 'package:cybersource_ios/cybersource_ios.dart';
import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CybersourceIOS', () {
    const kSessionId = 'MockSessionId';
    late CybersourceIOS cybersource;
    late List<MethodCall> log;

    setUp(() async {
      cybersource = CybersourceIOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(cybersource.methodChannel,
              (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getSessionId':
            return kSessionId;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      CybersourceIOS.registerWith();
      expect(CybersourcePlatform.instance, isA<CybersourceIOS>());
    });

    test('getSessionId returns correct sessionId', () async {
      final name = await cybersource.getSessionId(
        'mockOrderId',
        'mockOrgId',
        'mockFingerPrintUrl',
        'mockMerchantId',
      );
      expect(
        log,
        <Matcher>[
          isMethodCall(
            'getSessionId',
            arguments: <String, String>{
              'orderId': 'mockOrderId',
              'orgId': 'mockOrgId',
              'fingerprintServerUrl': 'mockFingerPrintUrl',
              'merchantId': 'mockMerchantId',
            },
          )
        ],
      );
      expect(name, equals(kSessionId));
    });
  });
}
