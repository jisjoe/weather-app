import 'package:http/http.dart';
import 'package:weather_app/config/flavor_config.dart';
import 'package:weather_app/constants/env/env.dart';
import 'package:weather_app/features/location/data_provider/remote_location_data_provider.dart';
import 'package:weather_app/features/location/exception/exception.dart';

class RemoteLocationDataProviderImpl implements RemoteLocationDataProvider {
  final Client _httpClient;

  RemoteLocationDataProviderImpl({required Client httpClient})
      : _httpClient = httpClient;

  @override
  Future<dynamic> locationSearch({
    required String location,
    int limit = 5,
  }) async {
    final locationRequest = Uri.https(
      Env.baseUrl,
      '/geo/1.0/direct',
      {
        'q': location,
        'appid': FlavorConfig.apiKey,
        'limit': '$limit',
      },
    );

    final locationResponse = await _httpClient.get(locationRequest);
    if (locationResponse.statusCode != 200) throw LocationRequestFailure();

    return locationResponse.body;
  }
}
