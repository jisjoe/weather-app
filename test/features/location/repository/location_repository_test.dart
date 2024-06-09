import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/location/data_provider/local_location_data_provider.dart';
import 'package:weather_app/features/location/data_provider/remote_location_data_provider.dart';
import 'package:weather_app/features/location/exception/exception.dart';
import 'package:weather_app/features/location/model/location.dart';
import 'package:weather_app/features/location/repository/location_repository.dart';
import 'package:weather_app/features/location/repository/location_repository_impl.dart';

class MockRemoteLocationDataProvider extends Mock
    implements RemoteLocationDataProvider {}

class MockLocalLocationDataProvider extends Mock
    implements LocalLocationDataProvider {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const Location(
        name: 'name',
        country: 'country',
        state: 'state',
      ),
    );
  });

  RemoteLocationDataProvider remoteLocationDataProvider =
      MockRemoteLocationDataProvider();
  LocalLocationDataProvider localLocationDataProvider =
      MockLocalLocationDataProvider();
  LocationRepository repository = LocationRepositoryImpl(
    localLocationDataProvider: localLocationDataProvider,
    remoteLocationDataProvider: remoteLocationDataProvider,
  );

  group('Location repository test', () {
    group(' - Location remote fetch', () {
      test(' - should return response when the network call is success',
          () async {
        const response =
            '[{"id":"","name":"Berlin","country":"Germany","state":"",'
            '"latitude":100.7,"longitude":20.9}]';

        when(() =>
                remoteLocationDataProvider.locationSearch(location: 'Berlin'))
            .thenAnswer((_) async => response);

        final result = await repository.fetchLocations(location: 'Berlin');
        expect(result.length, 1);
        expect(result.first.name, 'Berlin');
      });

      test(' -  should return response when the network call fails', () async {
        when(() =>
                remoteLocationDataProvider.locationSearch(location: 'Berlin'))
            .thenThrow(LocationNotFoundFailure());

        expect(
          repository.fetchLocations(location: 'Berlin'),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });
    });

    group(' - Location local fetch', () {
      const response = Location(
        name: 'Berlin',
        country: 'Germany',
        state: 'DE',
      );

      test(
          ' - should return response when the local saved location are available',
          () async {
        when(() => localLocationDataProvider.fetchSavedLocations())
            .thenAnswer((_) async => [response]);
        final result = await repository.fetchSavedLocations();
        expect(result.length, 1);
        expect(result.first.name, 'Berlin');
      });
    });

    group(' - Location local save', () {
      test(' - Should return true when the location is saved', () async {
        when(() => localLocationDataProvider.saveLocation(any()))
            .thenAnswer((_) async => true);

        expect(
          await repository.saveLocation(
            const Location(
              name: 'Berlin',
              country: 'Germany',
              state: 'DE',
            ),
          ),
          true,
        );
      });

      test(' - Should return `false` when location save fails', () async {
        when(() => localLocationDataProvider.saveLocation(any()))
            .thenAnswer((_) async => false);

        expect(
          await repository.saveLocation(const Location(
            name: 'Berlin',
            country: 'Germany',
            state: 'DE',
          )),
          false,
        );
      });
    });
  });
}
