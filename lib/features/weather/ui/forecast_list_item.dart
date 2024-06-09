import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/models/forecast/forecast.dart';

class ForecastListItem extends StatelessWidget {
  const ForecastListItem({
    super.key,
    required this.forecast,
  });

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              forecast.title,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Icon(
                  Icons.water_drop,
                  color: AppColors.white.withOpacity(0.7),
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  '${forecast.humidity}%',
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${forecast.maxTemp.toInt()}° ${forecast.minTemp.toInt()}°',
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
