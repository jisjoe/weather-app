import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/features/connectivity/bloc/connectivity_bloc.dart';
import 'package:weather_app/features/location/bloc/location_bloc.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/ui/weather_card.dart';

class ConnectivityWidget extends StatelessWidget {
  const ConnectivityWidget({super.key});

  bool listenWhen(ConnectivityState previous, ConnectivityState current) {
    return previous == ConnectivityState.disconnected &&
        current == ConnectivityState.connected;
  }

  @override
  Widget build(BuildContext context) {
    final locationBloc = context.read<LocationBloc>();
    final weatherCubit = context.read<WeatherCubit>();

    return BlocConsumer<ConnectivityBloc, ConnectivityState>(
      listenWhen: listenWhen,
      listener: (context, state) {
        if (state == ConnectivityState.connected) {
          Location? location = locationBloc.state.currentLocation;
          if (location != null) {
            context.read<WeatherCubit>().fetchWeather(
              latitude: location.latitude!,
              longitude: location.longitude!,
            );
          }
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        bool lastDataAvailable = weatherCubit.state.currentWeather != null;
        return switch (state) {
          ConnectivityState.disconnected => WeatherCard(
            child: Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.orange,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Internet connection unavailable. ${lastDataAvailable ? 'Last known forecast is shown.' : 'Please retry.'}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
