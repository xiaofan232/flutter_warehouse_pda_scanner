import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FlutterWarehousePdaScannerPlugin {
  static FlutterWarehousePdaScannerPlugin instance = FlutterWarehousePdaScannerPlugin._();
  // late final MethodChannel _channel;
  late final EventChannel _eventChannel;
  late StreamSubscription eventStreamSubscription;

  final StreamController _getStringStreamController = StreamController.broadcast();
  Stream get getBarcodeResp =>_getStringStreamController.stream;

  FlutterWarehousePdaScannerPlugin._() {
    // _channel = const MethodChannel("flutter_blue_elves/method");
    _eventChannel =
        const EventChannel("wyb.com/pda_scanner"); //定义接收底层操作系统主动发来的消息通道
    eventStreamSubscription = _eventChannel.receiveBroadcastStream().listen(
        _onEvent,
        onError: _onError); //注册消息回调函数;//广播流来处理EventChannel发来的消息
  }

  _onEvent(event) {
    if (event != null) {
      String eventString = event;
      try {
        //在这里做一些监听到参数的处理，可能会同步通知很多
        // final imMap = json.decode(eventString);
        _getStringStreamController.add(eventString);
        //监听到数据之后做各种解析
      }
      on FormatException
      catch(e) {
        debugPrint(e.message);
      }
      on NoSuchMethodError
      catch(e) {
        debugPrint(e.toString());
      }
    }
  }

  _onError(ex) {}
}
