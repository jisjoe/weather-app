import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/connectivity/enum/connectivity_source.dart';
import 'package:weather_app/features/connectivity/repository/connectivity_repository.dart';

part 'connectivity_event.dart';

part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityRepository _connectivityRepository;
  StreamSubscription<List<ConnectivitySource>>? connectivitySubscription;

  ConnectivityBloc({required ConnectivityRepository connectivityRepository})
      : _connectivityRepository = connectivityRepository,
        super(ConnectivityState.initial) {
    on<ConnectionListen>(_onConnectionListen);
    on<ConnectionChanged>(
      _onConnectionChanged,
      transformer: restartable(),
    );

    add(const ConnectionListen());
  }

  Future<void> _onConnectionListen(
    ConnectionListen event,
    Emitter<ConnectivityState> emit,
  ) async {
    connectivitySubscription =
        _connectivityRepository.onConnectivityChanged.listen((sources) {
      add(ConnectionChanged(sources));
    });
  }

  Future<void> _onConnectionChanged(
    ConnectionChanged event,
    Emitter<ConnectivityState> emit,
  ) async {
    final internetAvailable = await _connectivityRepository.lookupInternet();
    emit(internetAvailable
        ? ConnectivityState.connected
        : ConnectivityState.disconnected);
  }

  @override
  Future<void> close() async {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
