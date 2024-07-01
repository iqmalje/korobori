class Attendance {
  String attendanceID, activityID, accountAttended, picAdded;
  DateTime date;
  bool attendanceStatus;

  Attendance(
      {required this.attendanceID,
      required this.activityID,
      required this.accountAttended,
      required this.picAdded,
      required this.date,
      required this.attendanceStatus});
}
