import 'dart:async';

import 'package:korobori/controller/localDBcontroller.dart';
import 'package:korobori/models/activity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivityController {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Activity>> getAllActivities(String userid) async {
    List<Activity> activities = [];

    var data =
        await _supabase.rpc('get_all_activities', params: {'_userid': userid});
    for (var activity in data) {
      print(activity['attended_activity']);
      activities.add(
        Activity(
            activityID: activity['activity_idd'],
            activityPIC: activity['activity_pic'],
            activitySector: activity['activity_sector'],
            activityName: activity['activity_name'],
            activityIcons: 'assets/icons/${activity['activity_icons_id']}.svg',
            attendedActivity: activity['attended_activity']),
      );
    }

    return activities;
  }

  Future<List<Activity>> getAttendances(String userID) async {
    List<Activity> activities = [];
    var data = await _supabase
        .rpc('get_activities_attended', params: {'_userid': userID});

    for (var activity in data) {
      activities.add(Activity(
          activityID: activity['activity_idd'],
          activityPIC: activity['activity_pic'],
          activitySector: activity['activity_sector'],
          activityName: activity['activity_name'],
          activityIcons: 'assets/icons/${activity['activity_icons_id']}.svg',
          attendedActivity: true));
    }

    return activities;
  }

  Future<Map<String, dynamic>> getAttendancesBySubcamp(
      String activityID) async {
    try {
      var data = await _supabase.rpc('get_attendance_by_activity_subcamp',
          params: {'_activityid': activityID});

      return data[0];
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<int> countsOfPesertaInADate(String activityID, int dateID) async {
    var data = await _supabase.rpc('get_attendance_by_date',
        params: {'_activityid': activityID, '_dateid': dateID});

    return data[0]['count'];
  }

  Future<void> removeAttendance(String attendanceID) async {
    await _supabase
        .from('attendances')
        .update({'attendance_status': false}).eq('attendance_id', attendanceID);
  }

  Future<int> totalActivitiesAttended(String accountID) async {
    var data = await _supabase
        .from('attendance_each_user')
        .select('activities_count')
        .eq('account_id', accountID)
        .single();

    return data['activities_count'];
  }

  // Future<List<ActivityDates>> getActivityDates(String activityID) async {
  //   List<ActivityDates> activityDates = [];

  //   var data = await _supabase
  //       .from('activity_dates')
  //       .select('*')
  //       .eq('activity_id', activityID);

  //   for (var date in data) {
  //     int starthours = int.parse(date['start_time'].toString().split(':')[0]);
  //     int startminutes = int.parse(date['start_time'].toString().split(':')[1]);

  //     int endhours = int.parse(date['end_time'].toString().split(':')[0]);
  //     int endminutes = int.parse(date['end_time'].toString().split(':')[1]);

  //     activityDates.add(ActivityDates(
  //         id: date['id'],
  //         activityID: activityID,
  //         date: DateTime.parse(date['date']),
  //         startTime: TimeOfDay(hour: starthours, minute: startminutes),
  //         endTime: TimeOfDay(hour: endhours, minute: endminutes)));
  //   }

  //   return activityDates;
  // }

  SupabaseStreamFilterBuilder listenToAttendanceCount() {
    return _supabase.from('attendance_record').stream(primaryKey: ['id']);
  }

  SupabaseStreamBuilder listenToAttendanceRecord(
      String activityID, int activityDatesID) {
    return _supabase.from('attendances').stream(primaryKey: ['id']).eq(
        'unique_activity_date', "$activityID.$activityDatesID");
  }
  /*

  add_attendance(_scoutyid text, _activityid uuid, _dateid bigint, _picid uuid) 
  */

  StreamController<String> _controller = StreamController<String>();

  Stream<String> get stream => _controller.stream;

  Future<void> addAttendance(String activityID, int activityDatesID,
      {String? scoutyID, String? cardID}) async {
    try {
      // add to local db
      var localDB = await LocalDBController.initialize();

      var localID = await localDB.insertAttendanceLocal(scoutyID!, activityID,
          activityDatesID, _supabase.auth.currentUser!.id);
      _controller.add('LOCAL');

      // Try to upload to remote database
      await _supabase.rpc('add_attendance', params: {
        '_scoutyid': scoutyID,
        '_activityid': activityID,
        '_dateid': activityDatesID,
        '_picid': _supabase.auth.currentUser!.id,
      });

      // If successful, update local db status
      await localDB.updateStatusUpload(1, localID);
      _controller.add('CLOUD');
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
