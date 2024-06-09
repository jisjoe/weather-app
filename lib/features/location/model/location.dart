import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@Collection(inheritance: false)
@JsonSerializable()
class Location extends Equatable {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Id id = Isar.autoIncrement;

  @JsonKey(defaultValue: '')
  final String name, country, state;

  @JsonKey(name: 'lat')
  final double? latitude;

  @JsonKey(name: 'lon')
  final double? longitude;

  const Location({
    required this.name,
    required this.country,
    required this.state,
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @ignore
  @override
  List<Object?> get props => [
        name,
        country,
        state,
        latitude,
        longitude,
      ];
}
