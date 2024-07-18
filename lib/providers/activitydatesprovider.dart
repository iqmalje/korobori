import 'package:flutter/material.dart';
import 'package:korobori/models/activitydates.dart';

class ActivityDatesProvider extends ChangeNotifier {
  List<ActivityDates> activityDates = [
    ActivityDates(
        id: 2,
        date: DateTime(2024, 7, 22),
        startTime: const TimeOfDay(hour: 21, minute: 0),
        endTime: const TimeOfDay(hour: 23, minute: 0)),
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
        id: 7,
        date: DateTime(2024, 7, 23),
        startTime: const TimeOfDay(hour: 21, minute: 0),
        endTime: const TimeOfDay(hour: 23, minute: 0)),
    ActivityDates(
        id: 5,
        date: DateTime(2024, 7, 24),
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0)),
    ActivityDates(
        id: 6,
        date: DateTime(2024, 7, 24),
        startTime: const TimeOfDay(hour: 14, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0)),
    ActivityDates(
        id: 8,
        date: DateTime(2024, 7, 24),
        startTime: const TimeOfDay(hour: 20, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0)),
  ];
}
