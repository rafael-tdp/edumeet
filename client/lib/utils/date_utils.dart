import 'package:flutter/material.dart';
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

  static DateTime stringToFomattedDateTime(String date) {
    try {
      final parts = date.split('/');
      if (parts.length != 3) {
        throw FormatException('Invalid date format');
      }
      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];
      return DateTime.parse('$year-$month-$day');
    } catch (e) {
      throw FormatException('Invalid date');
    }
  }

  static Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Sélectionner votre date de naissance',
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale('fr', 'FR'),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
