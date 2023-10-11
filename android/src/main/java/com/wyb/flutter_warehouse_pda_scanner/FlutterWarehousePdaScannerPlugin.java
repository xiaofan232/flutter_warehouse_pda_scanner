package com.wyb.flutter_warehouse_pda_scanner;

import android.content.Context;
import android.content.BroadcastReceiver;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterWarehousePdaScannerPlugin
 */
public class FlutterWarehousePdaScannerPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    private Context applicationContext;

    private static final String _channel = "wyb.com/pda_scanner";

    /// 优博讯
    private static final String UROVO_SCAN_ACTION = "android.intent.ACTION_DECODE_DATA";
    /// 新大陆
    private static final String NL_SCAN_ACTION = "nlscan.action.SCANNER_RESULT";
    /// 霍尼韦尔
    private static final String HONEYWELL_SCAN_ACTION = "com.honeywell.decode.intent.action.EDIT_DATA";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_warehouse_pda_scanner");
        channel.setMethodCallHandler(this);


        new EventChannel(flutterPluginBinding.getBinaryMessenger(), _channel).setStreamHandler(
                new EventChannel.StreamHandler() {

                    private BroadcastReceiver barCodeReceiver;

                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        barCodeReceiver = createReceiver(events);
                        IntentFilter filter = new IntentFilter();
                        filter.addAction(UROVO_SCAN_ACTION);
                        filter.addAction(NL_SCAN_ACTION);
                        filter.addAction(HONEYWELL_SCAN_ACTION);
                        applicationContext.registerReceiver(barCodeReceiver, filter);
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        applicationContext.unregisterReceiver(barCodeReceiver);
                        barCodeReceiver = null;
                    }
                }
        );

        applicationContext = flutterPluginBinding.getApplicationContext();

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    private BroadcastReceiver createReceiver(final EventChannel.EventSink events) {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                String actionName = intent.getAction();
                System.out.println(actionName);
                if (UROVO_SCAN_ACTION.equals(actionName)) {
                    System.out.println("接收到广播数据>>>>>>>>>>>>>>" + intent.getStringExtra("barcode_string"));
                    events.success(intent.getStringExtra("barcode_string"));
                } else if (NL_SCAN_ACTION.equals(actionName)) {
                    System.out.println("接收到广播数据>>>>>>>>>>>>>>" + intent.getStringExtra("SCAN_BARCODE1"));
                    events.success(intent.getStringExtra("SCAN_BARCODE1"));
                } else if (HONEYWELL_SCAN_ACTION.equals(actionName)) {
                    System.out.println("接收到广播数据>>>>>>>>>>>>>>" + intent.getStringExtra("data"));
                    events.success(intent.getStringExtra("data"));
                }else {
//                    Log.i("PdaScannerPlugin", "NoSuchAction");
                    events.error("error", "error: NoSuchAction", null);
                }
            }
        };
    }
}
