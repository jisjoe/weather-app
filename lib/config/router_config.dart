import 'package:go_router/go_router.dart';
import 'package:weather_app/constants/routes.dart';
import 'package:weather_app/features/weather/ui/weather_page.dart';

final GoRouter appRouterConfig = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: AppRoutes.weatherPage,
      builder: (context, state) => const WeatherPage(),
    ),
  ],
);
