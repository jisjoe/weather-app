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

  Details? get currentWeatherDetails =>
      currentWeather?.details.isNotEmpty == true
          ? currentWeather?.details.first
          : null;

  List<Forecast> get forecasts => weather.forecastData.map((data) {
        return Forecast(
            title: DateTimeHelper.formatDate(data.dateText),
            humidity: data.temperature?.humidity ?? 0,
            minTemp: data.temperature?.tempMin ?? 0,
            maxTemp: data.temperature?.tempMax ?? 0);
      }).toList();

  bool get needColorOnIcon =>
      ['13d', '13n', '50d', '50n', '01n'].contains(currentWeatherDetails?.icon);

  String get temperatureUnit =>
      weatherUnits == WeatherUnits.imperial ? 'F' : 'C';

  String get windSpeedUnit =>
      weatherUnits == WeatherUnits.imperial ? 'mph' : 'm/s';

  String get weatherLongString =>
      '${currentTemperature?.tempMax?.toInt() ?? 0}°$temperatureUnit / '
      '${currentTemperature?.tempMin?.toInt() ?? 0}'
      '°$temperatureUnit Feels like ${currentTemperature?.feelsLike?.toInt() ?? 0}°'
      '$temperatureUnit';

  bool get isDark {
    DateTime now = DateTime.now();
    DateTime eveningTime = DateTime(now.year, now.month, now.day, 17);
    DateTime morningTime = DateTime(now.year, now.month, now.day + 1, 6);
    DateTime fetchedDate = DateTime.parse(
      currentWeather?.dateText ?? now.toString(),
    );
    return fetchedDate.isAfter(eveningTime) &&
        fetchedDate.isBefore(morningTime);
  }
}
