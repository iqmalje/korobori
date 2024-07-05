import 'package:flutter/material.dart';
import 'package:korobori/models/activity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivityController {
  SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Activity>> getAllActivities() async {
    List<Activity> activities = [];

    var data = await _supabase.from('activities').select('*');
    Icons.abc;
    for (var activity in data) {
      activities.add(Activity(
          activityID: activity['activity_id'],
          activityPIC: activity['activity_pic'],
          activitySector: activity['activity_sector'],
          activityName: activity['activity_name'],
          activityIcons: IconData(activity['activity_icons_id'],
              fontFamily: 'MaterialIcons')));
    }

    return activities;
  }
}
