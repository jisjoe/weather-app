import 'package:flutter/material.dart';
import 'package:weather_app/constants/color_gradients.dart';
import 'package:weather_app/constants/colors.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.child,
    this.title,
    this.titleAlignment,
  });

  final Widget child;
  final String? title;
  final CrossAxisAlignment? titleAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: AppColorGradients.weatherCard,
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      child: title == null
          ? child
          : Column(
              crossAxisAlignment: titleAlignment ?? CrossAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                child,
              ],
            ),
    );
  }
}
