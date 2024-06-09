import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/model/coordinate/coordinate.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(name: 'coord')
  Coordinate? coordinate;

  @JsonKey(defaultValue: '')
  String country;

  int? timezone;

  int? sunrise;

  int? sunset;

  City({
    required this.country,
    required this.name,
    this.coordinate,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
