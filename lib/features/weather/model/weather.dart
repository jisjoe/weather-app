import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/model/weather_data/weather_data.dart';
import 'package:weather_app/features/weather/model/city/city.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  @JsonKey(name: 'list', defaultValue: [])
  final List<WeatherData> forecastData;

  final City? city;

  const Weather({
    required this.forecastData,
    this.city,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  const Weather.empty()
      : city = null,
        forecastData = const [];

  @override
  List<Object?> get props => [
        forecastData,
        city,
      ];
}
