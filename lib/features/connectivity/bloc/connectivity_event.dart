part of 'connectivity_bloc.dart';

sealed class ConnectivityEvent {
  const ConnectivityEvent();
}

final class ConnectionListen extends ConnectivityEvent {
  const ConnectionListen();
}

final class ConnectionChanged extends ConnectivityEvent {
  final List<ConnectivitySource> sources;

  const ConnectionChanged(this.sources);
}
