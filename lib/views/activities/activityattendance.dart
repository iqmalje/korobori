import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/models/activity.dart';
import 'package:korobori/models/activitydates.dart';

class ActivityAttendance extends StatefulWidget {
  final Activity activity;
  final ActivityDates dateChosen;
  const ActivityAttendance(
      {super.key, required this.activity, required this.dateChosen});

  @override
  State<ActivityAttendance> createState() =>
      _ActivityAttendanceState(activity, dateChosen);
}

class _ActivityAttendanceState extends State<ActivityAttendance> {
  Activity activity;
  ActivityDates dateChosen;
  TextEditingController scoutyID = TextEditingController();
  _ActivityAttendanceState(this.activity, this.dateChosen);
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
                  height: 20,
                ),
                buildActivityInfo(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Bilangan Penyertaan Peserta',
                            style: KoroboriComponent().getTextStyle(
                              fontSize: 12,
                            )),
                        const Spacer(),
                        Text(
                          '3',
                          style: KoroboriComponent().getTextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildAttendanceInput(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Senarai Kehadiran Peserta',
                  style: KoroboriComponent()
                      .getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                buildAttendanceSearch(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildAttendanceSearch(BuildContext context) {
    return Container(
      width: 400,
      height: 420,
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
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05),
            child: Container(
              height: 40,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search),
                    hintStyle: KoroboriComponent().getTextStyle(
                        fontSize: 14,
                        style: FontStyle.italic,
                        color: Colors.black.withOpacity(0.25)),
                    hintText: 'Cari Scouty ID atau nama peserta'),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 2,
            decoration: const BoxDecoration(color: Color(0xFFEBEBEB)),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: ActivityController()
                  .listenToAttendanceRecord(activity.activityID, dateChosen.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      return buildAttendanceCard(
                          snapshot.data![index]['account_attended']);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snapshot.data!.length);
              })
        ],
      ),
    );
  }

  Widget buildAttendanceCard(String accountID) {
    return FutureBuilder(
        future: AuthController().findAccount(accountID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            width: 330,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 3,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          snapshot.data!.userFullname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: KoroboriComponent().getTextStyle(fontSize: 14),
                        ),
                        Text(
                          snapshot.data!.scoutyID,
                          style: KoroboriComponent().getTextStyle(fontSize: 10),
                        ),
                        Text(
                          '02:44 PM | K1',
                          style: KoroboriComponent().getTextStyle(fontSize: 10),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.red,
                      child: IconButton(
                          onPressed: () async {
                            bool? isDeleteConfirmed = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Padam Kehadiran',
                                          style: KoroboriComponent()
                                              .getTextStyle(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Adakah anda pasti anda ingin mengeluarkan peserta berikut daripada senarai kehadiran?',
                                          textAlign: TextAlign.center,
                                          style:
                                              KoroboriComponent().getTextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'KARIM BIN SAID',
                                          style: KoroboriComponent()
                                              .getTextStyle(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          'BP302',
                                          style: KoroboriComponent()
                                              .getTextStyle(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      KoroboriComponent().greyButton('Pasti',
                                          () {
                                        Navigator.of(context).pop(true);
                                      }),
                                      KoroboriComponent().blueButton('Batal',
                                          () {
                                        Navigator.of(context).pop(false);
                                      })
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 15,
                          )))
                ],
              ),
            ),
          );
        });
  }

  Container buildAttendanceInput() {
    return Container(
      height: 40,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          controller: scoutyID,
          onFieldSubmitted: (value) async {
            await ActivityController().addAttendance(
                activity.activityID, dateChosen.id,
                scoutyID: value);
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.person),
              hintStyle: KoroboriComponent().getTextStyle(
                  fontSize: 14,
                  style: FontStyle.italic,
                  color: Colors.black.withOpacity(0.25)),
              hintText: 'Sila masukkan Scouty ID peserta'),
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
              height: 10,
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
                Text("PANTAI AIR PAPAN, MERSING"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(
                  width: 10,
                ),
                Text(DateFormat("dd MMMM, hh:mm aa").format(dateChosen.date))
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
                Text(activity.activityPIC + "  |  F001"),
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
}
