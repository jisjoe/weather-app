import 'package:http/http.dart';
import 'package:weather_app/config/flavor_config.dart';
import 'package:weather_app/constants/env/env.dart';
import 'package:weather_app/features/weather/data_provider/remote_weather_data_provider.dart';
import 'package:weather_app/features/weather/exception/exception.dart';

class RemoteWeatherDataProviderImpl implements RemoteWeatherDataProvider {
  final Client _httpClient;

  RemoteWeatherDataProviderImpl({Client? httpClient})
      : _httpClient = httpClient ?? Client();

  @override
  Future<dynamic> readWeatherData({
    required double latitude,
    required double longitude,
    String? units = 'imperial',
  }) async {
    final weatherRequest = Uri.https(
      Env.baseUrl,
      '/data/2.5/forecast',
      {
        'lat': '$latitude',
        'appid': FlavorConfig.apiKey,
        'lon': '$longitude',
        'units': units,
      },
    );

    final weatherResponse = await _httpClient.get(weatherRequest);
    if (weatherResponse.statusCode != 200) throw WeatherRequestFailure();
    return weatherResponse.body;
  }
}
