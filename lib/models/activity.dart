import 'package:korobori/models/activity_icons.dart';

class Activity {
  String activityID, activityPIC, activitySector, activityName;
  ActivityIcons activityIcons;

  Activity({
    required this.activityID,
    required this.activityPIC,
    required this.activitySector,
    required this.activityName,
    required this.activityIcons,
  });
}
