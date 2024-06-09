import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/features/location/bloc/location_bloc.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';

class LocationSearchField extends StatefulWidget {
  const LocationSearchField({super.key});

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  final SuggestionsBoxController _suggestionController =
      SuggestionsBoxController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    final currentLocation = context.read<LocationBloc>().state.currentLocation;
    if (currentLocation != null) {
      _textEditingController.text = currentLocation.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.glacierBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(40),
      ),
      child: BlocConsumer<LocationBloc, LocationState>(
        listenWhen: (previous, current) =>
            previous.currentLocation != current.currentLocation,
        listener: (context, state) {
          if (state.currentLocation != null) {
            _textEditingController.text = state.currentLocation!.name;
            context.read<WeatherCubit>().fetchWeather(
                  latitude: state.currentLocation!.latitude!,
                  longitude: state.currentLocation!.longitude!,
                );
          }
        },
        builder: (context, state) {
          bool isDark = context.watch<WeatherCubit>().state.isDark;
          return DropDownSearchField<Location>(
            suggestionsBoxController: _suggestionController,
            displayAllSuggestionWhenTap: false,
            suggestionsBoxVerticalOffset: 10,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              color: isDark
                  ? AppColors.rhino.withOpacity(0.9)
                  : AppColors.cornflowerBlue.withOpacity(0.9),
              elevation: 2,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            textFieldConfiguration: TextFieldConfiguration(
              controller: _textEditingController,
              onTapOutside: (_) {
                _suggestionController.close();
                FocusScope.of(context).unfocus();
              },
              autofocus: false,
              cursorColor: AppColors.glacierBlue,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration.collapsed(
                hintText: state.currentLocation?.name ?? 'Berlin',
                hintStyle: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            noItemsFoundBuilder: (context) => const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Nothing found!',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
            suggestionsCallback: (pattern) async {
              if (pattern.isEmpty) return [];
              context
                  .read<LocationBloc>()
                  .add(SearchLocation(location: pattern));
              var resultStream =
                  await context.read<LocationBloc>().stream.firstWhere((state) {
                return [
                  SearchLocationStatus.failure,
                  SearchLocationStatus.success,
                  SearchLocationStatus.empty,
                ].contains(state.searchLocationStatus);
              });
              return resultStream.locations;
            },
            itemBuilder: (context, suggestion) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${suggestion.name}, ${suggestion.country}',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              context
                  .read<LocationBloc>()
                  .add(SaveLocation(location: suggestion));
            },
            loadingBuilder: (context) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
