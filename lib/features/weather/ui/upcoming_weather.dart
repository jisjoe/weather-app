import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/ui/weather_card.dart';
import 'package:weather_app/models/forecast/forecast.dart';

import 'forecast_list_item.dart';

class UpcomingWeather extends StatelessWidget {
  const UpcomingWeather({
    super.key,
    this.forecasts = const [],
  });

  final List<Forecast> forecasts;

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      title: 'Upcoming weather',
      titleAlignment: CrossAxisAlignment.start,
      child: ListView.builder(
        itemCount: forecasts.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ForecastListItem(
            forecast: forecasts[index],
          );
        },
      ),
    );
  }
}
