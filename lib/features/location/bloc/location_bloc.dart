import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/exception/exception.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/location/repository/location_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;

  LocationBloc({
    required LocationRepository locationRepository,
    required Location initialLocation,
  })  : _locationRepository = locationRepository,
        super(LocationState.initial(currentLocation: initialLocation)) {
    on<SearchLocation>(_onLocationSearchRequested, transformer: restartable());
    on<FetchSavedLocations>(_onFetchSavedLocations);
    on<SaveLocation>(_onSaveLocation);

    add(FetchSavedLocations());
  }

  Future<void> _onLocationSearchRequested(
    SearchLocation event,
    Emitter emit,
  ) async {
    try {
      emit(state.copyWith(searchLocationStatus: SearchLocationStatus.fetching));
      final List<Location> locations = await _locationRepository.fetchLocations(location: event.location);
      emit(
        state.copyWith(
          locations: locations,
          searchLocationStatus: SearchLocationStatus.success,
        ),
      );
    } on LocationNotFoundFailure catch (_) {
      emit(
        state.copyWith(
          locations: [],
          searchLocationStatus: SearchLocationStatus.empty,
        ),
      );
    } catch (_) {
      emit(state.copyWith(searchLocationStatus: SearchLocationStatus.failure));
    }
  }

  Future<void> _onFetchSavedLocations(
    FetchSavedLocations event,
    Emitter emit,
  ) async {
    try {
      emit(state.copyWith(fetchLocationsStatus: FetchLocationsStatus.fetching));
      final List<Location> locations = await _locationRepository.fetchSavedLocations();
      if (locations.isEmpty) {
        emit(state.copyWith(fetchLocationsStatus: FetchLocationsStatus.empty));
      } else {
        emit(state.copyWith(
          locations: locations,
          currentLocation: locations.last,
          fetchLocationsStatus: FetchLocationsStatus.success,
        ));
      }
    } catch (_) {
      emit(state.copyWith(fetchLocationsStatus: FetchLocationsStatus.failure));
    }
  }

  Future<void> _onSaveLocation(
    SaveLocation event,
    Emitter emit,
  ) async {
    try {
      emit(state.copyWith(saveLocationStatus: SaveLocationStatus.saving));
      final bool saved = await _locationRepository.saveLocation(event.location);
      emit(state.copyWith(
        saveLocationStatus: saved ? SaveLocationStatus.success : SaveLocationStatus.failure,
        currentLocation: event.location,
      ));
    } catch (_) {
      emit(state.copyWith(saveLocationStatus: SaveLocationStatus.failure));
    }
  }
}
