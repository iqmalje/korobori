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
                  height: 20,
                ),
                buildPenyertaanInfo(),
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

  Widget buildPenyertaanInfo() {
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
                Text(
                  'BILANGAN PENYERTAAN PESERTA',
                  style: KoroboriComponent().getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 0),
                ),
                const Spacer(),
                Text(
                  '1576',
                  style: KoroboriComponent()
                      .getTextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                )
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
                  '379',
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
                  '379',
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
                  '379',
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
                  '379',
                  style: KoroboriComponent()
                      .getTextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
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
                  height: 17,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    activity.activityName.toUpperCase() +
                        "jcnasjcjascjasbvjbasjvbbvajvbjbvsjbj",
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
                    activity.activityPIC +
                        "  |  F001" +
                        "jcnasjcjascjasbvjbasjvbbvajvb",
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
    if (time.hour <= 12) {
      output = "${time.hour} AM";
    } else {
      output = "${time.hour - 12} PM";
    }

    return output;
  }
}
