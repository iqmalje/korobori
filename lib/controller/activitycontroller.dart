import 'package:flutter/material.dart';
import 'package:korobori/models/activity.dart';
import 'package:korobori/models/activitydates.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivityController {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Activity>> getAllActivities({required String sektor}) async {
    List<Activity> activities = [];

    var data = await _supabase
        .from('activities')
        .select('*')
        .eq('activity_sector', sektor);
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

  Future<void> removeAttendance(String attendanceID) async {
    await _supabase
        .from('attendances')
        .update({'attendance_status': false}).eq('attendance_id', attendanceID);
  }

  Future<List<ActivityDates>> getActivityDates(String activityID) async {
    List<ActivityDates> activityDates = [];

    var data = await _supabase
        .from('activity_dates')
        .select('*')
        .eq('activity_id', activityID);

    for (var date in data) {
      int starthours = int.parse(date['start_time'].toString().split(':')[0]);
      int startminutes = int.parse(date['start_time'].toString().split(':')[1]);

      int endhours = int.parse(date['end_time'].toString().split(':')[0]);
      int endminutes = int.parse(date['end_time'].toString().split(':')[1]);

      activityDates.add(ActivityDates(
          id: date['id'],
          activityID: activityID,
          date: DateTime.parse(date['date']),
          startTime: TimeOfDay(hour: starthours, minute: startminutes),
          endTime: TimeOfDay(hour: endhours, minute: endminutes)));
    }

    return activityDates;
  }

  SupabaseStreamFilterBuilder listenToAttendanceCount() {
    return _supabase.from('attendance_record').stream(primaryKey: ['id']);
  }

  SupabaseStreamBuilder listenToAttendanceRecord(
      String activityID, int activityDatesID) {
    return _supabase.from('attendances').stream(primaryKey: ['id']).eq(
        'unique_activity_date', "$activityID.$activityDatesID");
  }

  Future<void> addAttendance(String activityID, int activityDatesID,
      {String? scoutyID, String? cardID}) async {
    String accountid = "";
    if (cardID == null) {
      var data = await _supabase
          .from('accounts')
          .select('id')
          .eq('scouty_id', scoutyID!)
          .single();
      accountid = data['id'];
    } else {
      //takde lagi
    }
    await _supabase.from('attendances').insert({
      'activity_id': activityID,
      'account_attended': accountid,
      'activity_dates_id': activityDatesID,
      'pic_added': _supabase.auth.currentUser!.id,
      'time': DateTime.now().toString(),
      'attendance_status': true
    });
  }
}
