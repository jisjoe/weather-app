import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/color_gradients.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/features/connectivity/ui/connectivity_widget.dart';
import 'package:weather_app/features/location/bloc/location_bloc.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/location/ui/location_search_field.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/ui/error_card.dart';
import 'package:weather_app/features/weather/ui/not_found_card.dart';
import 'package:weather_app/features/weather/ui/settings_drawer.dart';
import 'package:weather_app/features/weather/ui/weather_page_contents.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawerScrimColor: Colors.white12,
      drawer: SettingsDrawer(),
      body: WeatherPageBody(),
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

  Future<void> onRefresh() async {
    Location? location = context.read<LocationBloc>().state.currentLocation;

    if (location != null) {
      context.read<WeatherCubit>().fetchWeather(
            latitude: location.latitude!,
            longitude: location.longitude!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: state.isDark
                  ? AppColorGradients.backgroundGradientNight
                  : AppColorGradients.backgroundGradientDay,
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          borderRadius: BorderRadius.circular(30),
                          splashColor: AppColors.glacierBlue.withOpacity(0.5),
                          child: const Icon(
                            Icons.settings,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 4,
                            right: 16,
                          ),
                          child: LocationSearchField(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: onRefresh,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const SizedBox(height: 16),
                          const ConnectivityWidget(),
                          if (state.weatherStatus == WeatherStatus.success ||
                              state.isWeatherDataAvailable)
                            WeatherPageContents(
                              weatherLongString: state.weatherLongString,
                              isColorIcon: state.needColorOnIcon,
                              windSpeedUnit: state.windSpeedUnit,
                              currentTemperature: state.currentTemperature,
                              forecasts: state.forecasts,
                              currentWeather: state.currentWeather,
                              currentWeatherDetails:
                                  state.currentWeatherDetails,
                            )
                          else if (state.weatherStatus == WeatherStatus.initial)
                            loading()
                          else if (state.weatherStatus == WeatherStatus.loading)
                            loading()
                          else if (state.weatherStatus == WeatherStatus.failure)
                            const ErrorCard()
                          else if (state.weatherStatus ==
                              WeatherStatus.notFound)
                            const NotFoundCard()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
