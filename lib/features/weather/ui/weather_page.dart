import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/connectivity/bloc/connectivity_bloc.dart';
import 'package:weather_app/features/connectivity/repository/connectivity_repository_impl.dart';
import 'package:weather_app/features/connectivity/ui/connectivity_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (_) => ConnectivityBloc(
            connectivityRepository: ConnectivityRepositoryImpl(
              connectivity: Connectivity(),
            ),
          ),
          child: const ConnectivityWidget(),
        ),
      ),
    );
  }
}
