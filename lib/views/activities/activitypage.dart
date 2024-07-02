import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/models/activity.dart';
import 'package:korobori/views/activities/activityattendance.dart';

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
                horizontal: MediaQuery.sizeOf(context).width * 0.1),
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
            return TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ActivityAttendance(
                          activity: activity,
                          dateChosen: DateTime.now(),
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
                    '22 Jun, 8 AM - 12 PM',
                    style: KoroboriComponent().getTextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
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
          itemCount: 4,
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(activity.activityIcons),
                const SizedBox(
                  width: 10,
                ),
                Text(activity.activityName.toUpperCase()),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.pin_drop),
                SizedBox(
                  width: 10,
                ),
                Text("NI TAKDE SO KENE TAMBAH DALAM DB"),
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
                const Icon(Icons.person),
                const SizedBox(
                  width: 10,
                ),
                Text(activity.activityPIC),
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
}
