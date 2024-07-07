import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/models/activity.dart';
import 'package:korobori/views/activities/activitypage.dart';

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
                                  Flexible(
                                    child: Text(
                                      'Bilangan Aktiviti Berjaya Dilengkapkan',
                                      style: KoroboriComponent().getTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines:
                                          2, // Allow text to wrap to a new line
                                      overflow: TextOverflow
                                          .visible, // Handle overflow
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 25,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFFF0003),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '21 / 31',
                                        style: KoroboriComponent().getTextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Peserta perlu menyelesaikan sekurang-kurangnya 25 aktiviti daripada 31 aktiviti untuk melayakkan peserta mendapat sijil aktiviti.',
                                style: KoroboriComponent()
                                    .getTextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      KoroboriComponent().buildInput(TextEditingController(),
                          width: 0,
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
                  height: 15,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      buildSektor('KOMBAT', const Color(0xFF0000FF)),
                      buildSektor('NEURO', const Color(0xFFFFFF00)),
                      buildSektor('TEKNO', const Color(0xFFFF0000)),
                      buildSektor('INVISO', const Color(0xFF99FF00)),
                      buildSektor('FUSION', const Color(0xFF9397A0)),
                      buildSektor('PERTANDINGAN', const Color(0xFF9E00FF)),
                      buildSektor('LAIN-LAIN', const Color(0xFFFF8438)),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSektor(String sektor, Color color) {
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
            FutureBuilder(
                future: ActivityController()
                    .getAllActivities(sektor: sektor.toLowerCase()),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return buildActivity(snapshot.data![index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 2,
                        color: const Color.fromARGB(255, 217, 217, 217),
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
                }),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: Row(
              children: [
                Icon(activity.activityIcons),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    activity.activityName.toUpperCase(),
                    style: KoroboriComponent().getTextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                    maxLines: 2, // Allow text to wrap to a new line
                    overflow: TextOverflow.visible, // Handle overflow
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  /* 
              onTap: () {
                setState(() {
                  isCompleted = !isCompleted;
                });
              },
              */
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(
                          0xFF3BE542), //isCompleted ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.done, //isCompleted ? Icons.done : Icons.close,
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
