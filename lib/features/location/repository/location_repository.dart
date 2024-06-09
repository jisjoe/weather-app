import 'package:weather_app/features/location/model/location.dart';

abstract class LocationRepository {
  Future<List<Location>> fetchLocations({
    required String location,
    int limit = 5,
  });

  Future<List<Location>> fetchSavedLocations();

  Future<bool> saveLocation(Location location);
}
