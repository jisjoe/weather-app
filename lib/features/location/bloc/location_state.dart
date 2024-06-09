part of 'location_bloc.dart';

enum SearchLocationStatus {
  initial,
  fetching,
  success,
  empty,
  failure,
}

enum SaveLocationStatus {
  initial,
  saving,
  success,
  failure,
}

enum FetchLocationsStatus {
  initial,
  fetching,
  success,
  empty,
  failure,
}

class LocationState extends Equatable {
  final List<Location> locations;

  final String errorMessage;

  final SearchLocationStatus searchLocationStatus;
  final SaveLocationStatus saveLocationStatus;
  final FetchLocationsStatus fetchLocationsStatus;

  final Location? currentLocation;

  const LocationState({
    required this.locations,
    required this.errorMessage,
    required this.searchLocationStatus,
    required this.saveLocationStatus,
    required this.fetchLocationsStatus,
    this.currentLocation,
  });

  const LocationState.initial({this.currentLocation})
      : locations = const [],
        errorMessage = '',
        searchLocationStatus = SearchLocationStatus.initial,
        saveLocationStatus = SaveLocationStatus.initial,
        fetchLocationsStatus = FetchLocationsStatus.initial;

  @override
  List<Object?> get props => [
        errorMessage,
        locations,
        searchLocationStatus,
        saveLocationStatus,
        fetchLocationsStatus,
        currentLocation,
      ];

  LocationState copyWith({
    List<Location>? locations,
    String? errorMessage,
    SearchLocationStatus? searchLocationStatus,
    SaveLocationStatus? saveLocationStatus,
    FetchLocationsStatus? fetchLocationsStatus,
    Location? currentLocation,
  }) {
    return LocationState(
      locations: locations ?? this.locations,
      errorMessage: errorMessage ?? this.errorMessage,
      searchLocationStatus: searchLocationStatus ?? this.searchLocationStatus,
      saveLocationStatus: saveLocationStatus ?? this.saveLocationStatus,
      fetchLocationsStatus: fetchLocationsStatus ?? this.fetchLocationsStatus,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
