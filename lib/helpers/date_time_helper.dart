import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd/MM, h:mm a');
    final String formatted = formatter.format(date);
    return formatted;
  }
}
