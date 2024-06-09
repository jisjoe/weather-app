import 'package:weather_app/features/connectivity/enum/connectivity_source.dart';

abstract class ConnectivityRepository {
  Stream<List<ConnectivitySource>> get onConnectivityChanged;

  Future<bool> lookupInternet();
}
