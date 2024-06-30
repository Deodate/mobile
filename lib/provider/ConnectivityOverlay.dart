import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityOverlay extends StatefulWidget {
  @override
  _ConnectivityOverlayState createState() => _ConnectivityOverlayState();
}

class _ConnectivityOverlayState extends State<ConnectivityOverlay> {
  List<ConnectivityResult> _connectivityResults = [ConnectivityResult.none];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      setState(() {
        _connectivityResults = results;
        if (_connectivityResults.contains(ConnectivityResult.none)) {
          _showOverlay();
        } else {
          _removeOverlay();
        }
      });
    });
  }

  void _showOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Icon(
                Icons.signal_wifi_off,
                color: Colors.red,
                size: 48,
              ),
            ),
          ),
        ),
      );
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    ConnectivityResult currentConnectivity = _connectivityResults.isNotEmpty ? _connectivityResults.last : ConnectivityResult.none;

    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Overlay'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              currentConnectivity != ConnectivityResult.none
                  ? Icons.wifi
                  : Icons.signal_wifi_off,
              size: 100,
              color: currentConnectivity != ConnectivityResult.none
                  ? Colors.green
                  : Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              currentConnectivity != ConnectivityResult.none
                  ? 'Connected'
                  : 'No Internet',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
