class Forecast {
  const Forecast({
    required this.title,
    required this.humidity,
    required this.minTemp,
    required this.maxTemp,
  });

  final String title;
  final int humidity;
  final double minTemp;
  final double maxTemp;
}
