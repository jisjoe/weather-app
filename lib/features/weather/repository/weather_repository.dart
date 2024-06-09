import 'package:weather_app/features/weather/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
    String units = 'imperial',
  });
}
