import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryService {
  final Battery _battery = Battery();
   int _batteryLevel = 0;

  BatteryService() {
    _battery.onBatteryStateChanged.listen((BatteryState state) async {
      if (state == BatteryState.charging) {
        int batteryLevel = await _battery.batteryLevel;
        _handleBatteryLevel(batteryLevel);
      }
    });
  }

  void _handleBatteryLevel(int batteryLevel) {
    print("Battery level: $batteryLevel");
    if (batteryLevel == 100) {
      _showToast("Battery is charged to $batteryLevel%");
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}
