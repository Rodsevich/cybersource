import 'package:cybersource_android/cybersource_android.dart';
import 'package:cybersource_platform_interface/cybersource_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CybersourceAndroid', () {
    const kSessionId = 'MockSessionId';
    late CybersourceAndroid cybersource;
    late List<MethodCall> log;

    setUp(() async {
      cybersource = CybersourceAndroid();

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
      CybersourceAndroid.registerWith();
      expect(CybersourcePlatform.instance, isA<CybersourceAndroid>());
    });

    test('getSessionId returns correct sessionId', () async {
      final sessionId = await cybersource.getSessionId(
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
          ),
        ],
      );
      expect(sessionId, equals(kSessionId));
    });
  });
}
