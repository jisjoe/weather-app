import 'package:isar/isar.dart';
import 'package:weather_app/features/location/data_provider/local_location_data_provider.dart';
import 'package:weather_app/features/location/model/location.dart';

class LocalLocationDataProviderImpl extends LocalLocationDataProvider {
  final Isar _db;

  LocalLocationDataProviderImpl({required Isar isar}) : _db = isar;

  @override
  Future<bool> saveLocation(Location location) async {
    await _db.writeTxn(() async {
      // Check for existing location with the same latitude and longitude
      final existingLocationIds = await _db.locations
          .filter()
          .latitudeEqualTo(location.latitude)
          .and()
          .longitudeEqualTo(location.longitude)
          .idProperty()
          .findAll();

      // Remove existing locations by their id's
      for (final id in existingLocationIds) {
        await _db.locations.delete(id);
      }

      // Add the new location
      await _db.locations.put(location);
    });
    return true;
  }

  @override
  Future<List<Location>> fetchSavedLocations() async {
    return await _db.locations.where(distinct: true).findAll();
  }
}
