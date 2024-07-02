import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  Timer? _toastTimer;
  bool _initialNotificationReceived = false;

  ConnectivityService() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (!_initialNotificationReceived) {
        _initialNotificationReceived = true;
        return; // Ignore initial notification
      }

      if (_toastTimer != null && _toastTimer!.isActive) {
        _toastTimer!.cancel(); // Cancel previous timer
      }

      // Debounce the toast message to avoid showing multiple toasts in quick succession
      _toastTimer = Timer(Duration(seconds: 1), () {
        if (results.contains(ConnectivityResult.mobile)) {
          _showToast("Connected to Mobile Network", Colors.green);
        } else if (results.contains(ConnectivityResult.wifi)) {
          _showToast("Connected to WiFi", Colors.green);
        } else {
          _showToast("No Internet Connection", Colors.red);
        }
      });
    });
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white, // Adjust text color for better visibility
    );
  }

  void dispose() {
    _connectivitySubscription.cancel(); // Cancel the connectivity subscription
    _toastTimer?.cancel(); // Cancel any active timer
  }
}
