import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_warehouse_pda_scanner_method_channel.dart';

abstract class FlutterWarehousePdaScannerPlatform extends PlatformInterface {
  /// Constructs a FlutterWarehousePdaScannerPlatform.
  FlutterWarehousePdaScannerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterWarehousePdaScannerPlatform _instance =
      MethodChannelFlutterWarehousePdaScanner();

  /// The default instance of [FlutterWarehousePdaScannerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterWarehousePdaScanner].
  static FlutterWarehousePdaScannerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterWarehousePdaScannerPlatform] when
  /// they register themselves.
  static set instance(FlutterWarehousePdaScannerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
