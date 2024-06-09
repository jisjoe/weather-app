import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/weather/ui/weather_unit_action.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void onSettingsChanged(bool value) {
      final weatherCubit = context.read<WeatherCubit>();
      context.read<WeatherCubit>().unitChanged(value);
      const currentLocation = Location(
        name: 'Berlin',
        country: 'DE',
        state: '',
        latitude: 52.5170365,
        longitude: 13.3888599,
      );
      weatherCubit.fetchWeather(
        latitude: currentLocation.latitude ?? 0,
        longitude: currentLocation.longitude ?? 0,
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
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Unit',
                style: TextStyle(
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