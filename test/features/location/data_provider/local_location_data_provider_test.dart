import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:weather_app/features/location/data_provider/local_location_data_provider.dart';
import 'package:weather_app/features/location/data_provider/local_location_data_provider_impl.dart';
import 'package:weather_app/features/location/model/location.dart';

void main() {
  late Isar isar;
  late LocalLocationDataProvider localLocationDataProvider;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([LocationSchema], directory: 'test/scripts');
    localLocationDataProvider = LocalLocationDataProviderImpl(isar: isar);
  });

  test('- should return success when the data is cached', () async {
    const location = Location(name: 'Berlin', country: 'Germany', state: 'DE');
    final isSuccess = await localLocationDataProvider.saveLocation(location);
    expect(isSuccess, true);
  });

  test('- should return cached locations when cached data is present',
      () async {
    final locations = await localLocationDataProvider.fetchSavedLocations();
    expect(locations.length, 1);
  });
}
