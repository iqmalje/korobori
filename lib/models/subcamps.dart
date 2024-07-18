import 'dart:ui';

import 'package:korobori/models/subcampenum.dart';

class SubCamp {
  Subcamps name;
  String daerahs, imageURL;
  Color mainColor;
  int count, totalUser;

  SubCamp(
      {required this.name,
      required this.daerahs,
      required this.imageURL,
      required this.count,
      required this.totalUser,
      required this.mainColor});
}
