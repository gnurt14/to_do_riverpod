import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:to_do_riverpod/data/data.dart';

import '../providers/date_provider.dart';

class Helpers {
  Helpers._();

  static String timeToString(TimeOfDay time) {
    try {
      final DateTime now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      return DateFormat.jm().format(date);
    } catch (e) {
      return '12:00 pm';
    }
  }

  static void selectDate(BuildContext context, WidgetRef ref) async {
    final initDate = ref.read(dateProvider);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
    }
  }

  static bool isTaskFromSelectedDate(Task task, DateTime selectedDate) {
    final DateTime taskDate = _stringToDateTime(task.date);
    if (taskDate.year == selectedDate.year &&
        taskDate.month == selectedDate.month &&
        taskDate.day == selectedDate.day) {
      return true;
    }

    return false;
  }

  static DateTime _stringToDateTime(String dateString) {
    try {
      DateFormat format = DateFormat.yMMMd();
      return format.parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }
}
