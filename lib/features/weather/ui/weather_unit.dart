import 'package:flutter/cupertino.dart';
import 'package:weather_app/constants/colors.dart';

class WeatherUnitAction extends StatelessWidget {
  const WeatherUnitAction({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Imperial',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 10),
        CupertinoSwitch(
          value: value,
          activeColor: AppColors.white.withOpacity(0.2),
          trackColor: AppColors.white.withOpacity(0.2),
          onChanged: onChanged,
        ),
        const SizedBox(width: 10),
        const Text(
          'Metric',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
