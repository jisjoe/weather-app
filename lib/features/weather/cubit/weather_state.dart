part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure, notFound }

enum WeatherUnits { imperial, metric }

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;

  final WeatherUnits weatherUnits;

  final Weather weather;

  const WeatherState({
    required this.weatherStatus,
    required this.weather,
    required this.weatherUnits,
  });

  const WeatherState.initial()
      : weather = const Weather.empty(),
        weatherStatus = WeatherStatus.initial,
        weatherUnits = WeatherUnits.imperial;

  @override
  List<Object?> get props => [
        weatherStatus,
        weather,
        weatherUnits,
      ];

  WeatherState copyWith({
    Weather? weather,
    WeatherStatus? weatherStatus,
    WeatherUnits? weatherUnits,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weatherUnits: weatherUnits ?? this.weatherUnits,
    );
  }

  WeatherData? get currentWeather =>
      weather.forecastData.isNotEmpty ? weather.forecastData.first : null;

  Temperature? get currentTemperature => currentWeather?.temperature;
}
