import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/features/connectivity/repository/connectivity_repository.dart';
import 'package:weather_app/features/connectivity/repository/connectivity_repository_impl.dart';
import 'package:weather_app/features/location/data_provider/local_location_data_provider.dart';
import 'package:weather_app/features/location/data_provider/local_location_data_provider_impl.dart';
import 'package:weather_app/features/location/data_provider/remote_location_data_provider_impl.dart';
import 'package:weather_app/features/location/repository/location_repository.dart';
import 'package:weather_app/features/location/repository/location_repository_impl.dart';
import 'package:weather_app/features/weather/data_provider/remote_weather_data_provider_impl.dart';
import 'package:weather_app/features/weather/repository/weather_repository.dart';
import 'package:weather_app/features/weather/repository/weather_repository_impl.dart';
import 'package:weather_app/helpers/database_helper.dart';

class GlobalProviderScope extends StatelessWidget {
  final Widget child;

  const GlobalProviderScope({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final localLocationDataProvider =
        LocalLocationDataProviderImpl(isar: DatabaseHelper.isar!);
    final remoteLocationDataProvider =
        RemoteLocationDataProviderImpl(httpClient: Client());
    final remoteWeatherDataProvider =
        RemoteWeatherDataProviderImpl(httpClient: Client());

    return MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        // data providers
        RepositoryProvider<LocalLocationDataProvider>(
            create: (context) => localLocationDataProvider),
        RepositoryProvider<RemoteLocationDataProviderImpl>(
            create: (context) => remoteLocationDataProvider),

        // repositories
        RepositoryProvider<ConnectivityRepository>(
          create: (context) => ConnectivityRepositoryImpl(
            connectivity: Connectivity(),
          ),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepositoryImpl(
            remoteLocationDataProvider: remoteLocationDataProvider,
            localLocationDataProvider: localLocationDataProvider,
          ),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepositoryImpl(
            remoteWeatherDataProvider: remoteWeatherDataProvider,
          ),
        ),
      ],
      child: child,
    );
  }
}
