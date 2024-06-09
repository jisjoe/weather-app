import 'package:json_annotation/json_annotation.dart';

part 'temperature.g.dart';

@JsonSerializable()
class Temperature {
  @JsonKey(name: 'temp')
  double? currentTemperature;

  @JsonKey(name: 'feels_like')
  double? feelsLike;

  @JsonKey(name: 'temp_min')
  double? tempMin;

  @JsonKey(name: 'temp_max')
  double? tempMax;

  @JsonKey(name: 'sea_level')
  int? seaLevel;

  @JsonKey(name: 'grnd_level')
  int? groundLevel;

  int? pressure;

  int? humidity;

  Temperature({
    this.currentTemperature,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.groundLevel,
    this.seaLevel,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);
}
