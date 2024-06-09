import 'package:weather_app/features/location/model/location.dart';

abstract class LocalLocationDataProvider {
  Future<List<Location>> fetchSavedLocations();

  Future<bool> saveLocation(Location location);
}
