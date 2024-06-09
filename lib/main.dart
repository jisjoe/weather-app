import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/config/flavor_config.dart';
import 'package:weather_app/config/router_config.dart';

import 'helpers/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set the app flavor based on the configured value (if any).
  FlavorConfig.flavor = appFlavor?.toEnum();
  await DatabaseHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouterConfig,
    );
  }
}
