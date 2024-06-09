import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/features/weather/ui/weather_card.dart';

class NotFoundCard extends StatelessWidget {
  const NotFoundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const WeatherCard(
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.blueAccent,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'No data found! Please retry',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
