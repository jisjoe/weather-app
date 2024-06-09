import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/features/weather/model/details/details.dart';
import 'package:weather_app/features/weather/ui/weather_metrics.dart';
import 'package:weather_app/models/forecast/forecast.dart';
import 'package:weather_app/features/weather/model/temperature/temperature.dart';
import 'package:weather_app/features/weather/model/weather_data/weather_data.dart';
import 'package:weather_app/helpers/date_time_helper.dart';

class WeatherPageContents extends StatelessWidget {
  const WeatherPageContents({
    super.key,
    this.currentWeather,
    this.currentTemperature,
    this.currentWeatherDetails,
    required this.weatherLongString,
    required this.isColorIcon,
    this.forecasts = const [],
    required this.windSpeedUnit,
  });

  final WeatherData? currentWeather;
  final Temperature? currentTemperature;
  final Details? currentWeatherDetails;
  final String weatherLongString;
  final bool isColorIcon;
  final String windSpeedUnit;
  final List<Forecast> forecasts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${(currentTemperature?.currentTemperature)?.toInt() ?? 0}°',
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Text(
                      currentWeatherDetails?.weatherShortDescription ?? '',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.network(
                'https://openweathermap.org/img/wn/${currentWeatherDetails?.icon}@4x.png',
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                color: isColorIcon ? AppColors.white : null,
              ),
            ),
            const SizedBox(width: 12)
          ],
        ),
        const SizedBox(height: 20),
        Text(
          weatherLongString,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Text(
          DateTimeHelper.formatDate(
              currentWeather?.dateText ?? DateTime.now().toString()),
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        WeatherMetrics(
          humidity: '${currentTemperature?.humidity ?? 0}%',
          visibility: '${(currentWeather?.visibility ?? 0) ~/ 1000} km',
          pressure: '${currentTemperature?.pressure ?? 0} mb',
          wind: '${(currentWeather?.wind?.speed)?.toInt() ?? 0} $windSpeedUnit',
        ),
      ],
    );
  }
}
