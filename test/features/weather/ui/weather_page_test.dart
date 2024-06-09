import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/connectivity/bloc/connectivity_bloc.dart';
import 'package:weather_app/features/connectivity/enum/connectivity_source.dart';
import 'package:weather_app/features/connectivity/repository/connectivity_repository.dart';
import 'package:weather_app/features/connectivity/ui/connectivity_widget.dart';
import 'package:weather_app/features/location/bloc/location_bloc.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/location/repository/location_repository.dart';
import 'package:weather_app/features/location/ui/location_search_field.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/exception/exception.dart';
import 'package:weather_app/features/weather/model/weather.dart';
import 'package:weather_app/features/weather/model/weather_data/weather_data.dart';
import 'package:weather_app/features/weather/repository/weather_repository.dart';
import 'package:weather_app/features/weather/ui/error_card.dart';
import 'package:weather_app/features/weather/ui/not_found_card.dart';
import 'package:weather_app/features/weather/ui/settings_drawer.dart';
import 'package:weather_app/features/weather/ui/weather_page.dart';
import 'package:weather_app/features/weather/ui/weather_page_contents.dart';
import 'package:weather_app/features/weather/ui/weather_unit.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockConnectivityRepository extends Mock
    implements ConnectivityRepository {}

late LocationRepository locationRepository;
late WeatherRepository weatherRepository;
late ConnectivityRepository connectivityRepository;

const Location location = Location(
  name: 'Berlin',
  country: 'Germany',
  state: 'Hamburg',
  latitude: 53.5488,
  longitude: 9.9872,
);

Weather weather = Weather(forecastData: [
  WeatherData(
    name: 'Cloudy',
    dateText: DateTime.now().toString(),
    details: [],
  )
]);

List<BlocProvider> getBlocProviders() {
  return [
    BlocProvider<LocationBloc>.value(
      value: LocationBloc(
        locationRepository: locationRepository,
        initialLocation: location,
      ),
    ),
    BlocProvider<ConnectivityBloc>.value(
      value: ConnectivityBloc(
        connectivityRepository: connectivityRepository,
      ),
    ),
    BlocProvider<WeatherCubit>.value(
        value: WeatherCubit(
      weatherRepository: weatherRepository,
    )),
  ];
}

void main() {
  setUp(() {
    locationRepository = MockLocationRepository();
    weatherRepository = MockWeatherRepository();
    connectivityRepository = MockConnectivityRepository();

    when(() => connectivityRepository.onConnectivityChanged)
        .thenAnswer((_) => Stream.fromIterable([
              [ConnectivitySource.mobile]
            ]));
    when(() => connectivityRepository.lookupInternet())
        .thenAnswer((_) async => true);
  });

  group('WeatherPage Widget Tests', () {
    testWidgets(' - Renders WeatherPage and checks initial state',
        (WidgetTester tester) async {
      when(() => weatherRepository.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          )).thenAnswer((_) async => weather);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: getBlocProviders(),
            child: const WeatherPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify the WeatherPage is rendered correctly
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(WeatherPageBody), findsOneWidget);
      expect(find.byType(LocationSearchField), findsOneWidget);
      expect(find.byType(ConnectivityWidget), findsOneWidget);

      // Verify the SettingsDrawer is rendered correctly
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsDrawer), findsOneWidget);
    });

    testWidgets(' - Shows weather contents on success state',
        (WidgetTester tester) async {
      when(() => weatherRepository.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          )).thenAnswer((_) async => weather);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: getBlocProviders(),
            child: const WeatherPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify the success state is rendered correctly
      expect(find.byType(WeatherPageContents), findsOneWidget);
    });

    testWidgets(' - Re-fetch weather when unit button is toggled',
        (WidgetTester tester) async {
      when(() => weatherRepository.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          )).thenAnswer((_) async => weather);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: getBlocProviders(),
            child: const WeatherPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify the SettingsDrawer is rendered correctly
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsDrawer), findsOneWidget);

      var weatherAction = find.byType(WeatherUnitAction);
      expect(weatherAction, findsOneWidget);
      await tester.tap(weatherAction);
      await tester.pumpAndSettle();
      verify(
        () => weatherRepository.getWeather(
          latitude: 53.5488,
          longitude: 9.9872,
        ),
      ).called(1);
    });

    testWidgets(' - Shows error card on failure state',
        (WidgetTester tester) async {
      when(() => weatherRepository.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          )).thenThrow(Exception('Test exception'));
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: getBlocProviders(),
            child: const WeatherPage(),
          ),
        ),
      );
      await tester.pump();

      // Verify the error state is rendered correctly
      expect(find.byType(ErrorCard), findsOneWidget);
    });

    testWidgets(' - Shows not found card on not found state',
        (WidgetTester tester) async {
      when(() => weatherRepository.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          )).thenThrow(WeatherNotFoundFailure());
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: getBlocProviders(),
            child: const WeatherPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify the not found state is rendered correctly
      expect(find.byType(NotFoundCard), findsOneWidget);
    });
  });
}
