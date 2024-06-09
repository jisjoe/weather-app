import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/exception/exception.dart';
import 'package:weather_app/features/weather/model/weather.dart';
import 'package:weather_app/features/weather/repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockWeather extends Mock implements Weather {}

void main() {
  late WeatherRepository weatherRepository;
  late WeatherCubit weatherCubit;
  late Weather weatherData;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    weatherCubit = WeatherCubit(weatherRepository: weatherRepository);
    weatherData = MockWeather();
  });

  group('WeatherCubit', () {
    test('initial state is WeatherState.initial', () {
      expect(weatherCubit.state, const WeatherState.initial());
    });

    blocTest<WeatherCubit, WeatherState>(
      'emits [loading, success] when fetchWeather succeeds',
      build: () {
        when(() => weatherRepository.getWeather(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              units: any(named: 'units'),
            )).thenAnswer((_) async => weatherData);
        return weatherCubit;
      },
      act: (cubit) =>
          cubit.fetchWeather(latitude: 37.7749, longitude: -122.4194),
      expect: () => [
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.loading),
        const WeatherState.initial().copyWith(
          weatherStatus: WeatherStatus.success,
          weather: weatherData,
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [loading, notFound] when fetchWeather fails with WeatherNotFoundFailure',
      build: () {
        when(() => weatherRepository.getWeather(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              units: any(named: 'units'),
            )).thenThrow(WeatherNotFoundFailure());
        return weatherCubit;
      },
      act: (cubit) =>
          cubit.fetchWeather(latitude: 37.7749, longitude: -122.4194),
      expect: () => [
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.loading),
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.notFound),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [loading, failure] when fetchWeather fails with WeatherRequestFailure',
      build: () {
        when(() => weatherRepository.getWeather(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              units: any(named: 'units'),
            )).thenThrow(WeatherRequestFailure());
        return weatherCubit;
      },
      act: (cubit) =>
          cubit.fetchWeather(latitude: 37.7749, longitude: -122.4194),
      expect: () => [
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.loading),
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.failure),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [loading, failure] when fetchWeather fails with an unknown exception',
      build: () {
        when(() => weatherRepository.getWeather(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
              units: any(named: 'units'),
            )).thenThrow(Exception('unknown error'));
        return weatherCubit;
      },
      act: (cubit) =>
          cubit.fetchWeather(latitude: 37.7749, longitude: -122.4194),
      expect: () => [
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.loading),
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.failure),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits new state with updated units when unitChanged is called',
      build: () => weatherCubit,
      act: (cubit) => cubit.unitChanged(true),
      expect: () => [
        const WeatherState.initial()
            .copyWith(weatherUnits: WeatherUnits.metric),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits new state with updated units when unitChanged is called with false',
      build: () => weatherCubit,
      act: (cubit) => cubit.unitChanged(false),
      expect: () => [
        const WeatherState.initial()
            .copyWith(weatherUnits: WeatherUnits.imperial),
      ],
    );
  });
}
