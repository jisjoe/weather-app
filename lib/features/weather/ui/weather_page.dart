import 'package:flutter/material.dart';
import 'package:weather_app/features/connectivity/ui/connectivity_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ConnectivityWidget(),
      ),
    );
  }
}
