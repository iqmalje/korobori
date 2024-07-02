import 'package:flutter/cupertino.dart';

class Activity {
  String activityID, activityPIC, activitySector, activityName;
  IconData activityIcons;

  Activity({
    required this.activityID,
    required this.activityPIC,
    required this.activitySector,
    required this.activityName,
    required this.activityIcons,
  });
}
