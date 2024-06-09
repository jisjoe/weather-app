import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/color_gradients.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/features/location/bloc/location_bloc.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/ui/weather_unit.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void onSettingsChanged(bool value) {
      final weatherCubit = context.read<WeatherCubit>();
      context.read<WeatherCubit>().unitChanged(value);
      final currentLocation =
          context.read<LocationBloc>().state.currentLocation;
      weatherCubit.fetchWeather(
        latitude: currentLocation?.latitude ?? 0,
        longitude: currentLocation?.longitude ?? 0,
      );
    }

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            top: 60,
            bottom: 30,
            right: MediaQuery.of(context).size.width * 0.3,
          ),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:  state.isDark
                  ? AppColorGradients.backgroundGradientNight
                  : AppColorGradients.backgroundGradientDay,
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(30),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Unit',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              BlocBuilder<WeatherCubit, WeatherState>(
                buildWhen: (previous, current) =>
                previous.weatherUnits != current.weatherUnits,
                builder: (context, state) {
                  return WeatherUnitAction(
                    value: state.weatherUnits == WeatherUnits.imperial
                        ? false
                        : true,
                    onChanged: onSettingsChanged,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
