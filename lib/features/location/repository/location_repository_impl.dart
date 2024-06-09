import 'dart:convert';

import 'package:weather_app/features/location/data_provider/local_location_data_provider.dart';
import 'package:weather_app/features/location/repository/location_repository.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/location/exception/exception.dart';
import 'package:weather_app/features/location/data_provider/remote_location_data_provider.dart';

class LocationRepositoryImpl implements LocationRepository {
  final RemoteLocationDataProvider _remoteLocationDataProvider;
  final LocalLocationDataProvider _localLocationDataProvider;

  LocationRepositoryImpl({
    required RemoteLocationDataProvider remoteLocationDataProvider,
    required LocalLocationDataProvider localLocationDataProvider,
  })  : _remoteLocationDataProvider = remoteLocationDataProvider,
        _localLocationDataProvider = localLocationDataProvider;

  @override
  Future<List<Location>> fetchLocations({
    required String location,
    int limit = 5,
  }) async {
    List<Location> locations = [];
    final locationResponse = await _remoteLocationDataProvider.locationSearch(
      location: location,
      limit: limit,
    );

    final locationResults = jsonDecode(locationResponse) as List? ?? [];
    if (locationResults.isEmpty) throw LocationNotFoundFailure();

    locations =
        locationResults.map((location) => Location.fromJson(location)).toList();

    return locations;
  }

  @override
  Future<List<Location>> fetchSavedLocations() =>
      _localLocationDataProvider.fetchSavedLocations();

  @override
  Future<bool> saveLocation(Location location) =>
      _localLocationDataProvider.saveLocation(location);
}
