import 'package:intl/intl.dart';

class DateUtils {
  static String isoToFormattedDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  static String isoToFormattedTime(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      final now = DateTime.now();
      if (dateTime.year == now.year &&
          dateTime.month == now.month &&
          dateTime.day == now.day) {
        return DateFormat('HH:mm').format(dateTime);
      } else if (dateTime.year == now.year &&
          dateTime.month == now.month &&
          dateTime.day == now.day - 1) {
        return 'Hier';
      } else {
        return DateFormat('dd/MM/yyyy').format(dateTime);
      }
    } catch (e) {
      return 'Invalid date';
    }
  }

  static bool isEventPassed(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    final now = DateTime.now();
    return dateTime.isBefore(now);
  }
}
