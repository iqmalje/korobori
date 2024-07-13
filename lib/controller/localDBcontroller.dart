import 'package:sqflite/sqflite.dart';

class LocalDBController {
  late Database _db;

  LocalDBController._initialize() {
    // I HAVE NOTHINGGG
  }

  static Future<LocalDBController> initialize() async {
    var path = await getDatabasesPath();
    var component = LocalDBController._initialize();

    component._db = await openDatabase("$path/attendance.db", version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE attendances (attendance_id INTEGER PRIMARY KEY, scouty_id TEXT, activity_id TEXT, date_id INTEGER, pic_id TEXT, upload_status INTEGER)');
    });

    return component;
  }

  Future<int> insertAttendanceLocal(
      String scoutyID, String activityID, int dateID, String picID) async {
    return _db.insert('attendances', {
      'scouty_id': scoutyID,
      'activity_id': activityID,
      'date_id': dateID,
      'pic_id': picID,
      'upload_status': 0
    });
  }

  /// status 0 is false and status 1 is true
  Future<void> updateStatusUpload(int status, int attendanceID) async {
    _db.update('attendances', {'upload_status': status},
        where: "attendance_id=$attendanceID");
  }

  Future<List<Map<String, dynamic>>> getAllAttendance() async {
    var data = await _db.rawQuery("SELECT * FROM attendances");
    return data;
  }
}
