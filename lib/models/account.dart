import 'package:korobori/models/school.dart';
import 'package:korobori/models/scout.dart';

class Account {
  String accountID, scoutyID, schoolCode, subcamp, userFullname, icNo, role;
  bool sijilApproved;
  School? school;
  Scout? scout;
  Account(
      {required this.accountID,
      required this.scoutyID,
      required this.schoolCode,
      required this.subcamp,
      required this.userFullname,
      required this.icNo,
      required this.role,
      this.scout,
      this.school,
      required this.sijilApproved});
}
