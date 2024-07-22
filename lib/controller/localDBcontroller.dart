import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/models/school.dart';
import 'package:korobori/models/scout.dart';
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
      // create local account
      await db.execute(
          'CREATE TABLE account (id TEXT PRIMARY KEY, fullname TEXT, ic_no TEXT, user_roles TEXT, school_code TEXT, scouty_id TEXT, subcamp TEXT, approve_sijil INTEGER, card_id TEXT, school_name TEXT, no_kumpulan TEXT, school_daerah TEXT, no_keahlian TEXT, age integer, gender TEXT, religion TEXT, parent_name TEXT, parent_phone_no TEXT)');
    });

    return component;
  }

  Future<void> deleteAccount() async {
    await _db.delete('account', where: '1=1');
  }

  Future<void> insertAccount(Account account) async {
    // delete everything first
    await _db.delete('account', where: '1=1');

    await _db.insert('account', {
      'id': account.accountID,
      'fullname': account.userFullname,
      'ic_no': account.icNo,
      'user_roles': account.role,
      'school_code': account.schoolCode,
      'scouty_id': account.scoutyID,
      'subcamp': account.subcamp,
      'approve_sijil': account.sijilApproved ? 1 : 0,
      'school_name': account.school!.schoolName,
      'no_kumpulan': account.school!.noKumpulan,
      'school_daerah': account.school!.schoolDaerah,
      'no_keahlian': account.scout!.noKeahlian,
      'age': account.scout!.age,
      'gender': account.scout!.gender,
      'religion': account.scout!.religion,
      'parent_name': account.scout!.parentName,
      'parent_phone_no': account.scout!.parentPhoneNo,
    });
  }

  Future<Account?> getAccount(String userID) async {
    Account accountTEMP;

    var data = await _db.query('account', where: 'id = ?', whereArgs: [userID]);

    if (data.isEmpty) return null;

    Map<String, dynamic> dataSingle;

    dataSingle = data[0];

    // ensure to fetch role and approve sijil from DB to avoid user modification

    Map<String, dynamic> dataRoleAndApproveSijil =
        await AuthController().fetchUserRoleAndApprove(userID);

    print(dataRoleAndApproveSijil);

    var scout = Scout(
        scoutyID: dataSingle['scouty_id'],
        noKeahlian: dataSingle['no_keahlian'] ?? '-',
        gender: dataSingle['gender'],
        religion: dataSingle['religion'] ?? '-',
        parentName: dataSingle['parent_name'] ?? '-',
        parentPhoneNo: dataSingle['parent_phone_no'] ?? '-',
        profileImageURL: 'none',
        displayName: 'none',
        age: dataSingle['age'] ?? 0);

    School school = School(
        schoolCode: dataSingle['school_code'],
        schoolName: dataSingle['school_name'],
        noKumpulan: dataSingle['no_kumpulan'],
        schoolDaerah: dataSingle['school_daerah']);

    accountTEMP = Account(
        accountID: dataSingle['id'],
        scoutyID: dataSingle['scouty_id'],
        schoolCode: dataSingle['school_code'],
        subcamp: dataSingle['subcamp'],
        userFullname: dataSingle['fullname'],
        icNo: dataSingle['ic_no'],
        role: dataRoleAndApproveSijil['user_roles'],
        sijilApproved: dataRoleAndApproveSijil['approve_sijil'],
        scout: scout,
        school: school);

    return accountTEMP;
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
