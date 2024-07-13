import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/models/activity.dart';
import 'package:korobori/models/activitydates.dart';
import 'package:korobori/providers/activitydatesprovider.dart';
import 'package:korobori/urusetia/views/activities/activityattendance.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatefulWidget {
  final Activity activity;
  const ActivityPage({super.key, required this.activity});

  @override
  State<ActivityPage> createState() => _ActivityPageState(activity);
}

class AttendanceNotifier extends ChangeNotifier {
  int _attendanceCount = 0;

  int get attendanceCount => _attendanceCount;

  void updateAttendanceCount(int count) {
    _attendanceCount = count;
    notifyListeners();
  }
}

class _ActivityPageState extends State<ActivityPage> {
  Activity activity;

  _ActivityPageState(this.activity);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: KoroboriComponent().getPrimaryColor(),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: KoroboriComponent()
              .buildAppBarWithBackbutton('Rekod Kehadiran', context),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.08),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                buildActivityInfo(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.refresh,
                        color:
                            Colors.black, // You can change the color as needed
                        size: 20, // Adjust the size as needed
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: ActivityController()
                        .getAttendancesBySubcamp(activity.activityID),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      print(snapshot.data!);

                      return buildPenyertaanInfo(snapshot.data!);
                    }),
                const SizedBox(
                  height: 20,
                ),
                buildDates()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDates() {
    return Column(
      children: [
        Text(
          'Sesi Aktiviti',
          style: KoroboriComponent().getTextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            ActivityDates activityDate =
                context.read<ActivityDatesProvider>().activityDates[index];
            return TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ActivityAttendance(
                          activity: activity,
                          dateChosen: activityDate,
                        )));
              },
              child: Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: KoroboriComponent().getPrimaryColor(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Center(
                  child: Text(
                    '${DateFormat('dd MMMM').format(activityDate.date)}, ${getFormattedTime(activityDate.startTime)} - ${getFormattedTime(activityDate.endTime)}',
                    style: KoroboriComponent().getTextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: context.read<ActivityDatesProvider>().activityDates.length,
        )
      ],
    );
  }

  Widget buildPenyertaanInfo(Map<String, dynamic> attendances) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'BILANGAN PENYERTAAN PESERTA',
                    style: KoroboriComponent().getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 0,
                    ),
                    maxLines: 2, // Allow up to 2 lines
                    overflow: TextOverflow
                        .ellipsis, // Optional, add ellipsis if overflow
                  ),
                ),
                const SizedBox(
                    width:
                        8), // Optional, add some space between text and number
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    (attendances['count_kombat']! +
                            attendances['count_tekno']! +
                            attendances['count_inviso']! +
                            attendances['count_neuro']!)
                        .toString(),
                    style: KoroboriComponent().getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF0000FF),
                  radius: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'SUBKEM KOMBAT',
                  style: KoroboriComponent().getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0),
                ),
                const Spacer(),
                Text(
                  attendances['count_kombat'].toString(),
                  style: KoroboriComponent()
                      .getTextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFFF0003),
                  radius: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'SUBKEM TEKNO',
                  style: KoroboriComponent().getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0),
                ),
                const Spacer(),
                Text(
                  attendances['count_tekno'].toString(),
                  style: KoroboriComponent()
                      .getTextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF3EAD16),
                  radius: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'SUBKEM INVISO',
                  style: KoroboriComponent().getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0),
                ),
                const Spacer(),
                Text(
                  attendances['count_inviso'].toString(),
                  style: KoroboriComponent()
                      .getTextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFFF8438),
                  radius: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'SUBKEM NEURO',
                  style: KoroboriComponent().getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0),
                ),
                const Spacer(),
                Text(
                  attendances['count_neuro'].toString(),
                  style: KoroboriComponent()
                      .getTextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kemaskini : ${DateFormat('dd/MM/yy, HH:mm:ss').format(DateTime.now())}',
                  style: KoroboriComponent().getTextStyle(fontSize: 10),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  Container buildActivityInfo() {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  activity.activityIcons,
                  height: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    activity.activityName.toUpperCase(),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.pin_drop),
                SizedBox(
                  width: 10,
                ),
                Text("PANTAI AIR PAPAN, MERSING"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.workspace_premium),
                const SizedBox(
                  width: 10,
                ),
                Text("SEKTOR ${activity.activitySector.toUpperCase()}"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.account_circle),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    activity.activityPIC,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  String getFormattedTime(TimeOfDay time) {
    String output = "";
    if (time.hour < 12) {
      output = "${time.hour} AM";
    } else if (time.hour == 12) {
      output = "${time.hour} PM";
    } else {
      output = "${time.hour - 12} PM";
    }

    return output;
  }
}
