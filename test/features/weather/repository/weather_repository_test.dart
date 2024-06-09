import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/weather/data_provider/remote_weather_data_provider.dart';
import 'package:weather_app/features/weather/exception/exception.dart';
import 'package:weather_app/features/weather/repository/weather_repository.dart';
import 'package:weather_app/features/weather/repository/weather_repository_impl.dart';

class MockRemoteWeatherDataProvider extends Mock
    implements RemoteWeatherDataProvider {}

void main() {
  RemoteWeatherDataProvider weatherDataProvider =
      MockRemoteWeatherDataProvider();

  WeatherRepository repository = WeatherRepositoryImpl(
    remoteWeatherDataProvider: weatherDataProvider,
  );

  group('Weather repository test', () {
    test(' -  should return weather data when the request is success',
        () async {
      final response = jsonEncode({
        "cod": "200",
        "message": 0,
        "cnt": 40,
        "list": [
          {
            "dt": 1717912800,
            "main": {
              "temp": 289.96,
              "feels_like": 289.13,
              "temp_min": 289.96,
              "temp_max": 290.61,
              "pressure": 1009,
              "sea_level": 1009,
              "grnd_level": 925,
              "humidity": 55,
              "temp_kf": -0.65
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04d"
              }
            ],
          }
        ],
        "city": {
          "id": 3163858,
          "name": "Zocca",
          "coord": {"lat": 44.34, "lon": 10.99},
          "country": "IT",
          "population": 4593,
          "timezone": 7200,
          "sunrise": 1717903922,
          "sunset": 1717959533
        }
      });

      when(() => weatherDataProvider.readWeatherData(
          latitude: 44.34, longitude: 10.99)).thenAnswer(
        (_) async => response,
      );

      final weather = await repository.getWeather(
        latitude: 44.34,
        longitude: 10.99,
      );

      expect(weather.forecastData.length, 1);
      expect(
        weather.forecastData.first.temperature?.currentTemperature,
        289.96,
      );
    });

    test(
        ' -  should throw `WeatherNotFoundFailure` when weather is not present',
        () async {
      final response = jsonEncode({
        "cod": "200",
        "message": 0,
        "cnt": 40,
        "list": [],
      });

      when(() => weatherDataProvider.readWeatherData(
          latitude: 44.34, longitude: 10.99)).thenAnswer(
        (_) async => response,
      );

      expect(
        repository.getWeather(latitude: 44.34, longitude: 10.99),
        throwsA(isA<WeatherNotFoundFailure>()),
      );
    });
  });
}
