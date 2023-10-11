import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_warehouse_pda_scanner/flutter_warehouse_pda_scanner.dart';
import 'package:flutter_warehouse_pda_scanner/flutter_warehouse_pda_scanner_platform_interface.dart';
import 'package:flutter_warehouse_pda_scanner/flutter_warehouse_pda_scanner_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterWarehousePdaScannerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterWarehousePdaScannerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterWarehousePdaScannerPlatform initialPlatform = FlutterWarehousePdaScannerPlatform.instance;

  test('$MethodChannelFlutterWarehousePdaScanner is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterWarehousePdaScanner>());
  });

  test('getPlatformVersion', () async {
    FlutterWarehousePdaScanner flutterWarehousePdaScannerPlugin = FlutterWarehousePdaScanner();
    MockFlutterWarehousePdaScannerPlatform fakePlatform = MockFlutterWarehousePdaScannerPlatform();
    FlutterWarehousePdaScannerPlatform.instance = fakePlatform;

    expect(await flutterWarehousePdaScannerPlugin.getPlatformVersion(), '42');
  });
}
