import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/connectivity/ui/connectivity_widget.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/location/ui/location_search_field.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/ui/settings_drawer.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WeatherPageBody(),
      drawer: SettingsDrawer(),
    );
  }
}

class WeatherPageBody extends StatefulWidget {
  const WeatherPageBody({super.key});

  @override
  State<WeatherPageBody> createState() => _WeatherPageBodyState();
}

class _WeatherPageBodyState extends State<WeatherPageBody> {
  @override
  void initState() {
    // refresh page initially to fetch current location  weather
    onRefresh();
    super.initState();
  }

  void onRefresh() {
    Location? location = const Location(
      name: 'Berlin',
      country: 'DE',
      state: '',
      latitude: 52.5170365,
      longitude: 13.3888599,
    );

    context.read<WeatherCubit>().fetchWeather(
          latitude: location.latitude!,
          longitude: location.longitude!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 16),
                      const LocationSearchField(),
                      const ConnectivityWidget(),
                      ...switch (state.weatherStatus) {
                        WeatherStatus.initial => [
                            loading(),
                          ],
                        WeatherStatus.loading => [
                            loading(),
                          ],
                        WeatherStatus.success => [
                            Text(state.currentTemperature?.currentTemperature
                                    ?.toString() ??
                                '0')
                          ],
                        WeatherStatus.failure => [const Text('Error')],
                        WeatherStatus.notFound => [const Text('Not Found')]
                      }
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget loading() {
    return const Column(
      children: [
        CircularProgressIndicator(),
      ],
    );
  }
}
