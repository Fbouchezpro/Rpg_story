// ignore_for_file: file_names

import 'package:intl/intl.dart';

String displayBeautifulShortHour({
  required DateTime date,
  required bool use24HourFormat,
  bool useDecimal = false,
}) =>
    use24HourFormat
        ? DateFormat().add_Hm().format(date)
        : useDecimal
            ? DateFormat().add_jm().format(date)
            : DateFormat().add_j().format(date);

String displayDayMonth({required DateTime date}) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month';
}
