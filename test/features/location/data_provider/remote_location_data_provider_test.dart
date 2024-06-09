import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/config/flavor_config.dart';
import 'package:weather_app/features/location/data_provider/remote_location_data_provider.dart';
import 'package:weather_app/features/location/data_provider/remote_location_data_provider_impl.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('Remote location data provider test', () {
    late http.Client httpClient;
    late RemoteLocationDataProvider dataProvider;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      FlavorConfig.flavor = Flavor.dev;
      httpClient = MockHttpClient();
      dataProvider = RemoteLocationDataProviderImpl(httpClient: httpClient);
    });

    group('getWeather', () {
      test(' - location search test', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        await dataProvider.locationSearch(
          location: 'location',
          limit: 5,
        );

        verify(
          () => httpClient.get(
            Uri.https('api.openweathermap.org', '/geo/1.0/direct', {
              'q': 'location',
              'appid': FlavorConfig.apiKey,
              'limit': '5',
            }),
          ),
        ).called(1);
      });
    });
  });
}
