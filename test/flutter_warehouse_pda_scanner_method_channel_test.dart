import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_warehouse_pda_scanner/flutter_warehouse_pda_scanner_method_channel.dart';

void main() {
  MethodChannelFlutterWarehousePdaScanner platform = MethodChannelFlutterWarehousePdaScanner();
  const MethodChannel channel = MethodChannel('flutter_warehouse_pda_scanner');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
