import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/models/activity.dart';
import 'package:korobori/providers/accountprovider.dart';
import 'package:provider/provider.dart';

class ActivitiesPagePemimpin extends StatefulWidget {
  const ActivitiesPagePemimpin({super.key});

  @override
  State<ActivitiesPagePemimpin> createState() => _ActivitiesPagePemimpinState();
}

class _ActivitiesPagePemimpinState extends State<ActivitiesPagePemimpin> {
  TextEditingController searchActivities = TextEditingController();
  List<Activity> kombatActivities = [];
  List<Activity> neuroActivities = [];
  List<Activity> teknoActivities = [];
  List<Activity> invisoActivities = [];
  List<Activity> fusionActivities = [];
  List<Activity> lainActivities = [];
  List<Activity> pertandinganActivities = [];
  String textSearch = "";
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
            appBar: KoroboriComponent().buildAppBar(context, 'Aktiviti'),
            body: FutureBuilder(
                future: ActivityController().getAllActivities(
                    context.read<AccountProvider>().account!.accountID),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.sizeOf(context).width * 0.05),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MediaQuery(
                                          data: MediaQuery.of(context)
                                              .copyWith(textScaler: const TextScaler.linear(1.0)),
                                          child: Flexible(
                                            child: Text(
                                              'Bilangan Aktiviti Berjaya Dilengkapkan',
                                              style: KoroboriComponent()
                                                  .getTextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines:
                                                  2, // Allow text to wrap to a new line
                                              overflow: TextOverflow
                                                  .visible, // Handle overflow
                                            ),
                                          ),
                                        ),
                                        Builder(builder: (context) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }

                                          int count = snapshot.data!
                                              .where((element) => (element
                                                          .attendedActivity ==
                                                      true &&
                                                  (element.activitySector !=
                                                          'pertandingan' &&
                                                      element.activitySector !=
                                                          'lain-lain')))
                                              .length;

                                          return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      textScaler: const TextScaler.linear(1.0)),
                                              child: Container(
                                                width: 50,
                                                height: 25,
                                                decoration: ShapeDecoration(
                                                  color: count >= 20
                                                      ? const Color(0xFF3BE542)
                                                      : const Color(0xFFFF0003),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '$count / 28',
                                                    style: KoroboriComponent()
                                                        .getTextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ));
                                        }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(textScaler: const TextScaler.linear(1.0)),
                                      child: Text(
                                        'Peserta perlu menyelesaikan sekurang-kurangnya 20 aktiviti daripada 28 aktiviti untuk melayakkan peserta mendapat sijil aktiviti.',
                                        style: KoroboriComponent()
                                            .getTextStyle(fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            KoroboriComponent().buildInput(
                                context, searchActivities, width: 0, height: 40,
                                onChange: (text) {
                              setState(() {
                                textSearch = text;
                              });
                            },
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
                        child: Builder(builder: (context) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          kombatActivities = snapshot.data!
                              .where((activity) =>
                                  activity.activitySector == 'kombat')
                              .toList();
                          neuroActivities = snapshot.data!
                              .where((activity) =>
                                  activity.activitySector == 'neuro')
                              .toList();
                          teknoActivities = snapshot.data!
                              .where((activity) =>
                                  activity.activitySector == 'tekno')
                              .toList();
                          invisoActivities = snapshot.data!
                              .where((activity) =>
                                  activity.activitySector == 'inviso')
                              .toList();
                          fusionActivities = snapshot.data!
                              .where((activity) =>
                                  activity.activitySector == 'fusion')
                              .toList();
                          lainActivities = snapshot.data!
                              .where((activity) =>
                                  activity.activitySector == 'lain-lain')
                              .toList();
                          pertandinganActivities = snapshot.data!
                              .where((activity) =>
                                  activity.activitySector == 'pertandingan')
                              .toList();

                          return Builder(builder: (context) {
                            List<Activity> activities = [
                              ...kombatActivities,
                              ...neuroActivities,
                              ...teknoActivities,
                              ...invisoActivities,
                              ...fusionActivities,
                              ...lainActivities,
                              ...pertandinganActivities
                            ];

                            activities = activities
                                .where((element) => element.activityName
                                    .toLowerCase()
                                    .contains(textSearch.toLowerCase()))
                                .toList();

                            if (textSearch.isNotEmpty) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return buildActivity(activities[index]);
                                  },
                                  itemCount: activities.length);
                            } else {
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
                                  buildSektor(
                                      'PERTANDINGAN',
                                      const Color(0xFF9E00FF),
                                      pertandinganActivities),
                                  buildSektor('LAIN-LAIN',
                                      const Color(0xFFFF8438), lainActivities),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            }
                          });
                        }),
                      )
                    ],
                  );
                }),
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
                  MediaQuery(
                      data:
                          MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: Text(
                        'SEKTOR $sektor',
                        style: KoroboriComponent()
                            .getTextStyle(fontWeight: FontWeight.w600),
                      ))
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
        onTap: () {},
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
                MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: Expanded(
                    child: Text(
                      activity.activityName.toUpperCase(),
                      style: KoroboriComponent().getTextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                      maxLines: 3, // Allow text to wrap to a new line
                      overflow: TextOverflow.visible, // Handle overflow
                    ),
                  ),
                ),

                //const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: activity.attendedActivity
                          ? const Color(0xFF3BE542)
                          : const Color(0xFFD9D9D9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      activity.attendedActivity ? Icons.done : Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
