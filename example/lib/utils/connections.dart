import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class InternetConnectivity {
  InternetConnectivity();

  static InternetConnectivity init() {
    return InternetConnectivity();
  }

  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  bool _isWifiConnected = false;

  Stream get myStream => _controller.stream;

  bool get isWifiConnected => _isWifiConnected;

  Future<void> initialise() async {
    List<ConnectivityResult> connectivityResult = await _connectivity.checkConnectivity();

    _checkStatus(connectivityResult);
    _connectivity.onConnectivityChanged.listen((connectivityResult) async {
      _checkStatus(connectivityResult);
    });
  }

  Future<bool> hasInternet() async {
    try {
      if (kIsWeb) return true;
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      return false;
    }
  }

  void _checkStatus(List<ConnectivityResult> connectivityResult) async {
    late bool result;
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      _isWifiConnected = true;
      result = true;
    } else if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      result = true;
    }
    // device has no mobile network and wifi connection at all
    else {
      result = false;
      _isWifiConnected = false;
    }

    bool isOnline = await hasInternet();
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
