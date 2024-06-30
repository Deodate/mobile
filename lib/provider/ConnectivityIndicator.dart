import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityIndicator extends StatefulWidget {
  @override
  _ConnectivityIndicatorState createState() => _ConnectivityIndicatorState();
}

class _ConnectivityIndicatorState extends State<ConnectivityIndicator> {
  List<ConnectivityResult> _connectivityResults = [ConnectivityResult.none];

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      setState(() {
        _connectivityResults = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ConnectivityResult currentConnectivity = _connectivityResults.isNotEmpty ? _connectivityResults.last : ConnectivityResult.none;

    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Indicator'),
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
