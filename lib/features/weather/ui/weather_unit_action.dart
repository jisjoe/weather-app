import 'package:flutter/cupertino.dart';

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
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 10),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(width: 10),
        const Text(
          'Metric',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}