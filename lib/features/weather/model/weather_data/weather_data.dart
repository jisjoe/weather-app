import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/model/details/details.dart';
import 'package:weather_app/features/weather/model/temperature/temperature.dart';
import 'package:weather_app/features/weather/model/wind/wind.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  @JsonKey(name: 'weather', defaultValue: [])
  List<Details> details;

  Wind? wind;

  @JsonKey(name: 'main')
  Temperature? temperature;

  @JsonKey(name: 'dt')
  int? date;

  @JsonKey(defaultValue: '')
  String name;

  int? visibility;

  @JsonKey(name: 'dt_txt', defaultValue: '')
  String dateText;

  WeatherData({
    required this.name,
    required this.dateText,
    required this.details,
    this.temperature,
    this.wind,
    this.date,
    this.visibility,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}
