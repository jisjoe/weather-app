part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

final class SearchLocation extends LocationEvent {
  final String location;

  const SearchLocation({required this.location});
}

final class FetchSavedLocations extends LocationEvent {}

final class SaveLocation extends LocationEvent {
  final Location location;

  const SaveLocation({required this.location});
}

