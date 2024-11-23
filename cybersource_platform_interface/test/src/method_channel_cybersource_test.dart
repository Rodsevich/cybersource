import 'package:cybersource_platform_interface/src/method_channel_cybersource.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kSessionId = 'mockSessionId';

  group('$MethodChannelCybersource', () {
    late MethodChannelCybersource methodChannelCybersource;
    final log = <MethodCall>[];

    setUp(() async {
      methodChannelCybersource = MethodChannelCybersource();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        methodChannelCybersource.methodChannel,
        (methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'getSessionId':
              return kSessionId;
            default:
              return null;
          }
        },
      );
    });

    tearDown(log.clear);

    test('getSessionId', () async {
      final sessionId = await methodChannelCybersource.getSessionId(
        'mockOrderId',
        'mockOrgId',
        'mockFingerPrintUrl',
        'mockMerchantId',
      );
      expect(
        log,
        <Matcher>[isMethodCall('getSessionId', arguments: null)],
      );
      expect(sessionId, equals(kSessionId));
    });
  });
}
