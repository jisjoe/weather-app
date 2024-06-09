import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/ui/weather_card.dart';
import 'package:weather_app/constants/colors.dart';

class WeatherMetrics extends StatelessWidget {
  const WeatherMetrics({
    super.key,
    required this.humidity,
    required this.visibility,
    required this.pressure,
    required this.wind,
  });

  final String humidity;
  final String visibility;
  final String pressure;
  final String wind;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: WeatherCard(
                title: 'Humidity',
                child: Text(
                  humidity,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: WeatherCard(
                title: 'Visibility',
                child: Text(
                  visibility,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: WeatherCard(
                title: 'Pressure',
                child: Text(
                  pressure,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: WeatherCard(
                title: 'Wind',
                child: Text(
                  wind,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
