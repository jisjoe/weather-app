import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/connectivity/bloc/connectivity_bloc.dart';

class ConnectivityWidget extends StatelessWidget {
  const ConnectivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        return Text(state.name);
      },
    );
  }
}
