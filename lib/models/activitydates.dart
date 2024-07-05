import 'package:flutter/material.dart';

class ActivityDates {
  int id;
  String activityID;

  DateTime date;
  TimeOfDay startTime, endTime;

  ActivityDates(
      {required this.id,
      required this.activityID,
      required this.date,
      required this.startTime,
      required this.endTime});
}
