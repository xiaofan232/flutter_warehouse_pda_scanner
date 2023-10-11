# flutter_warehouse_pda_scanner

A Flutter plugin that supports PDA scanning barcodes.

## Getting Started

This project is only for Android PDA.

### Install

Add the `flutter_warehouse_pda_scanner` package to your
[pubspec dependencies](https://pub.dev/packages/flutter_warehouse_pda_scanner/install).

### Super simple to use

```dart
import 'package:flutter_warehouse_pda_scanner/flutter_warehouse_pda_scanner_plugin.dart';

FlutterWarehousePdaScannerPlugin.instance.getBarcodeResp.listen((event) {
  debugPrint("barCode -- $event");
});
```

## Awesome dio
## Supported PDA Types
-  [x] NL(新大陆)-PDA
-  [x] UROVO(优博讯)-PDA
-  [x] HONEYWELL(霍尼韦尔)-PDA


