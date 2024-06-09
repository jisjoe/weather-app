import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/features/connectivity/bloc/connectivity_bloc.dart';
import 'package:weather_app/features/weather/ui/weather_card.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    bool haveInternet =
        context.read<ConnectivityBloc>().state == ConnectivityState.connected;
    return Column(
      children: [
        Lottie.asset(
          'assets/lottie/something_went_wrong.json',
          height: 250,
        ),
        if (haveInternet)
          const WeatherCard(
            child: Row(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Something went wrong! Please refresh.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
