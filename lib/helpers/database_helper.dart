import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/features/location/model/location.dart';

class DatabaseHelper {
  static Isar? isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([LocationSchema], directory: dir.path);
  }
}
