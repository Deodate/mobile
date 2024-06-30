import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryService {
  final Battery _battery = Battery();

  BatteryService() {
    _battery.onBatteryStateChanged.listen((BatteryState state) async {
      if (state == BatteryState.charging) {
        int batteryLevel = await _battery.batteryLevel;
        if (batteryLevel >= 90) {
          _showToast("Battery is charged to $batteryLevel%");
        }
      }
    });
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
