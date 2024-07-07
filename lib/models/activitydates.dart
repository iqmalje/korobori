import 'package:flutter/material.dart';

class ActivityDates {
  int id;

  DateTime date;
  TimeOfDay startTime, endTime;

  ActivityDates(
      {required this.id,
      required this.date,
      required this.startTime,
      required this.endTime});
}
