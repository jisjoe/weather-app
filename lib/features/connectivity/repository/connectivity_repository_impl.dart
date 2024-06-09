import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app/features/connectivity/enum/connectivity_source.dart';
import 'package:weather_app/features/connectivity/repository/connectivity_repository.dart';

class ConnectivityRepositoryImpl extends ConnectivityRepository {
  final Connectivity _connectivity;

  ConnectivityRepositoryImpl({required Connectivity connectivity})
      : _connectivity = connectivity;

  @override
  Stream<List<ConnectivitySource>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged
        .map((results) => results.map(_mapConnectivityResultToSource).toList());
  }

  ConnectivitySource _mapConnectivityResultToSource(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return ConnectivitySource.wifi;
      case ConnectivityResult.mobile:
        return ConnectivitySource.mobile;
      case ConnectivityResult.bluetooth:
        return ConnectivitySource.bluetooth;
      case ConnectivityResult.ethernet:
        return ConnectivitySource.ethernet;
      case ConnectivityResult.none:
        return ConnectivitySource.none;
      default:
        return ConnectivitySource.other;
    }
  }

  @override
  Future<bool> lookupInternet() async {
    try {
      final addresses = await InternetAddress.lookup('google.com');
      return addresses.isNotEmpty;
    } on SocketException catch (_) {
      // Handle socket exceptions (e.g., no internet connection)
      return false;
    } catch (e) {
      return false;
    }
  }
}
