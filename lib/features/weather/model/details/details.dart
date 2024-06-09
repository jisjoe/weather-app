import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
  @JsonKey(name: 'main', defaultValue: '')
  String weatherShortDescription;

  @JsonKey(name: 'description', defaultValue: '')
  String weatherLongDescription;

  @JsonKey(defaultValue: '')
  String icon;

  Details({
    required this.weatherShortDescription,
    required this.weatherLongDescription,
    required this.icon,
  });

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
