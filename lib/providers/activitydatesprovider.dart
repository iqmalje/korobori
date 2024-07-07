import 'package:flutter/material.dart';
import 'package:korobori/models/activitydates.dart';

class ActivityDatesProvider extends ChangeNotifier {
  List<ActivityDates> activityDates = [
    ActivityDates(
        id: 3,
        date: DateTime(2024, 7, 23),
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0)),
    ActivityDates(
        id: 4,
        date: DateTime(2024, 7, 23),
        startTime: const TimeOfDay(hour: 14, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0)),
    ActivityDates(
        id: 5,
        date: DateTime(2024, 7, 23),
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0)),
    ActivityDates(
        id: 6,
        date: DateTime(2024, 7, 23),
        startTime: const TimeOfDay(hour: 14, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0)),
  ];
}
