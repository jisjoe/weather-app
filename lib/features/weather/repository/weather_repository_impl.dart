import 'dart:convert';

import 'package:weather_app/features/weather/data_provider/remote_weather_data_provider.dart';
import 'package:weather_app/features/weather/model/weather.dart';
import 'package:weather_app/features/weather/repository/weather_repository.dart';
import 'package:weather_app/features/weather/exception/exception.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteWeatherDataProvider _remoteWeatherDataProvider;

  WeatherRepositoryImpl({
    required RemoteWeatherDataProvider remoteWeatherDataProvider,
  }) : _remoteWeatherDataProvider = remoteWeatherDataProvider;

  @override
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
    String units = 'imperial',
  }) async {
    final weatherResponse = await _remoteWeatherDataProvider.readWeatherData(
      latitude: latitude,
      longitude: longitude,
      units: units,
    );

    final weatherResponseJson =
        jsonDecode(weatherResponse) as Map<String, dynamic>? ?? {};
    final weather = Weather.fromJson(weatherResponseJson);

    if (weather.forecastData.isEmpty) throw WeatherNotFoundFailure();
    return weather;
  }
}
