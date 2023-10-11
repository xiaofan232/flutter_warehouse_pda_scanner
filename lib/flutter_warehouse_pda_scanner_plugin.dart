import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FlutterWarehousePdaScannerPlugin {
  static FlutterWarehousePdaScannerPlugin instance =
      FlutterWarehousePdaScannerPlugin._();
  // late final MethodChannel _channel;
  late final EventChannel _eventChannel;
  // late StreamSubscription _eventStreamSubscription;

  final StreamController _getStringStreamController =
      StreamController.broadcast();
  Stream get getBarcodeResp => _getStringStreamController.stream;
  static const String eventChannelName = "wyb.com/pda_scanner";

  FlutterWarehousePdaScannerPlugin._() {
    _eventChannel = const EventChannel(eventChannelName); //定义接收底层操作系统主动发来的消息通道
    _eventChannel.receiveBroadcastStream().listen(_onEvent,
        onError: _onError); //注册消息回调函数;//广播流来处理EventChannel发来的消息
  }

  _onEvent(event) {
    if (event != null) {
      String eventString = event;
      try {
        _getStringStreamController.add(eventString);
      } on FormatException catch (e) {
        debugPrint(e.message);
      } on NoSuchMethodError catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  _onError(ex) {}
}
