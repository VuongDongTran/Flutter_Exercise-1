import 'dart:core';

import 'package:intl/intl.dart';

const _epochTicks = 621355968000000000;

extension DateTimeExtension on DateTime {
  /// Format [DateTime] with patern 'HH:mm, dd/MM/yyyy'
  String formatHmFull({String? day}) {
    if (day != null) {
      return DateFormat('HH:mm, ').format(this) +
          day +
          DateFormat(' dd/MM/yyyy').format(this);
    }
    return DateFormat('HH:mm,').format(this) +
        DateFormat(' dd/MM/yyyy').format(this);
  }

  /// Format [DateTime] to 'HH:mm, dd/MM/yyyy'
  String toHHmmDate() {
    return DateFormat('HH:mm').format(this) +
        DateFormat(' dd/MM/yyyy').format(this);
  }

  String toDDMMYYY() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String convertDatetimeToFormat() {
    final String datetime = toUtc().toIso8601String();
    final DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(datetime);
    final inputDate = DateTime.parse(parseDate.toString());
    final outputFormat = DateFormat('hh:mm dd/MM/yyyy');
    final outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  DateTime round30MinuteILead() {
    final int deltaMinute;
    if (minute < 30 && minute != 00) {
      deltaMinute = 30 - minute; // go to 30 minutes
    } else if (minute < 60 && minute != 00 && minute != 30) {
      deltaMinute = 60 - minute; // go to next hour with 0 minute
    } else {
      deltaMinute = 0; // go back to 0
    }
    return DateTime(year, month, day, hour, minute + deltaMinute);
  }

  int get ticks => microsecondsSinceEpoch * 10 + _epochTicks;

  num get toTicks => ((hour * 60) + minute) * 60000000;

  DateTime get timeInDate => DateTime(0001, 01, 01, hour, minute);

  DateTime get getDate => DateTime(year, month, day);

  DateTime get getDateHourMinute => DateTime(year, month, day, hour, minute);

  DateTime get lastOfDay => DateTime(year, month, day, 23, 59, 59, 999);
}
