import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/model/temperature/temperature.dart';
import 'package:weather_app/features/weather/model/weather.dart';
import 'package:weather_app/features/weather/model/weather_data/weather_data.dart';
import 'package:weather_app/features/weather/repository/weather_repository.dart';
import 'package:weather_app/features/weather/exception/exception.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherState.initial());

  Future<void> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      emit(state.copyWith(weatherStatus: WeatherStatus.loading));
      final weather = await _weatherRepository.getWeather(
        latitude: latitude,
        longitude: longitude,
        units: state.weatherUnits.name,
      );
      emit(
        state.copyWith(
          weatherStatus: WeatherStatus.success,
          weather: weather,
        ),
      );
    } on WeatherNotFoundFailure catch (_) {
      emit(state.copyWith(weatherStatus: WeatherStatus.notFound));
    } on WeatherRequestFailure catch (_) {
      emit(state.copyWith(weatherStatus: WeatherStatus.failure));
    } catch (_) {
      emit(state.copyWith(weatherStatus: WeatherStatus.failure));
    }
  }

  void unitChanged(bool value) {
    final WeatherUnits weatherUnits =
        value ? WeatherUnits.metric : WeatherUnits.imperial;
    emit(state.copyWith(weatherUnits: weatherUnits));
  }
}
