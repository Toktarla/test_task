import 'package:intl/intl.dart';

class DateFormatHelper {
  static String getCurrentDateInRussian() {
    final now = DateTime.now();
    final formatter = DateFormat('d MMMM', 'ru_RU');
    final dateString = formatter.format(now);

    final timeFormatter = DateFormat('HH:mm', 'ru_RU');
    final timeString = timeFormatter.format(now);

    return '$dateString $timeString';
  }
}