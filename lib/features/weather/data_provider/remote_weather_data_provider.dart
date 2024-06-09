abstract class RemoteWeatherDataProvider {
  Future<dynamic> readWeatherData({
    required double latitude,
    required double longitude,
    String? units = 'imperial',
  });
}
