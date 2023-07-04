import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:developer' as developer;

extension ConnectivityCheck on BuildContext {
  Future<ConnectivityResult> checkConnectivity() async {
    final Connectivity _connectivity = Connectivity();
    try {
      return await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return ConnectivityResult.none;
    }
  }
}
