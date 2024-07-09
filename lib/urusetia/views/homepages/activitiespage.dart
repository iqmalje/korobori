import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/models/activity.dart';
import 'package:korobori/providers/accountprovider.dart';
import 'package:korobori/urusetia/views/activities/activitypage.dart';
import 'package:provider/provider.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        color: KoroboriComponent().getPrimaryColor(),
        child: SafeArea(
          child: Scaffold(
            appBar: KoroboriComponent().buildAppBar('Aktiviti'),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.05),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      KoroboriComponent().buildInput(TextEditingController(),
                          width: 0,
                          height: 40,
                          shadows: [
                            const BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 1,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Cari nama aktiviti'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: ActivityController().getAllActivities(
                          context.read<AccountProvider>().account!.accountID),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List<Activity> kombatActivities = snapshot.data!
                            .where((activity) =>
                                activity.activitySector == 'kombat')
                            .toList();
                        List<Activity> neuroActivities = snapshot.data!
                            .where((activity) =>
                                activity.activitySector == 'neuro')
                            .toList();
                        List<Activity> teknoActivities = snapshot.data!
                            .where((activity) =>
                                activity.activitySector == 'tekno')
                            .toList();
                        List<Activity> invisoActivities = snapshot.data!
                            .where((activity) =>
                                activity.activitySector == 'inviso')
                            .toList();
                        List<Activity> fusionActivities = snapshot.data!
                            .where((activity) =>
                                activity.activitySector == 'fusion')
                            .toList();
                        List<Activity> lainActivities = snapshot.data!
                            .where((activity) =>
                                activity.activitySector == 'lain-lain')
                            .toList();
                        List<Activity> pertandinganActivities = snapshot.data!
                            .where((activity) =>
                                activity.activitySector == 'pertandingan')
                            .toList();

                        return ListView(
                          shrinkWrap: true,
                          children: [
                            buildSektor('KOMBAT', const Color(0xFF0000FF),
                                kombatActivities),
                            buildSektor('NEURO', const Color(0xFFFFFF00),
                                neuroActivities),
                            buildSektor('TEKNO', const Color(0xFFFF0000),
                                teknoActivities),
                            buildSektor('INVISO', const Color(0xFF99FF00),
                                invisoActivities),
                            buildSektor('FUSION', const Color(0xFF9397A0),
                                fusionActivities),
                            buildSektor('PERTANDINGAN', const Color(0xFF9E00FF),
                                pertandinganActivities),
                            buildSektor('LAIN-LAIN', const Color(0xFFFF8438),
                                lainActivities),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSektor(String sektor, Color color, List<Activity> activities) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.25))
        ]),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 35,
                    decoration: BoxDecoration(color: color),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'SEKTOR $sektor',
                    style: KoroboriComponent()
                        .getTextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: const Color.fromARGB(255, 217, 217, 217),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return buildActivity(activities[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  color: const Color.fromARGB(255, 217, 217, 217),
                );
              },
              itemCount: activities.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActivity(Activity activity) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ActivityPage(
                    activity: activity,
                  )));
        },
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: Row(
              children: [
                SvgPicture.asset(
                  activity.activityIcons,
                  height: 17,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    activity.activityName.toUpperCase(),
                    style: KoroboriComponent().getTextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    maxLines: 3, // Allow text to wrap to a new line
                    overflow: TextOverflow.visible, // Handle overflow
                  ),
                ),
                //const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
