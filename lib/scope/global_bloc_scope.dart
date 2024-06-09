import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/connectivity/bloc/connectivity_bloc.dart';
import 'package:weather_app/features/connectivity/repository/connectivity_repository.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/repository/weather_repository.dart';

class GlobalBlocScope extends StatelessWidget {
  final Widget child;

  const GlobalBlocScope({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final connectivityRepository = context.read<ConnectivityRepository>();
    final weatherRepository = context.read<WeatherRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          lazy: false,
          create: (context) =>
              ConnectivityBloc(connectivityRepository: connectivityRepository),
        ),
        BlocProvider<WeatherCubit>(
          lazy: false,
          create: (context) =>
              WeatherCubit(weatherRepository: weatherRepository),
        ),
      ],
      child: child,
    );
  }
}
