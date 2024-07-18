import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/models/account.dart';
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
  List<Account> accountsFetched = [];

  String searchText = "";
  TextEditingController scoutyID = TextEditingController(),
      searchScout = TextEditingController();
  _ActivityAttendanceState(this.activity, this.dateChosen);
  FocusNode textFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: KoroboriComponent().getPrimaryColor(),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: KoroboriComponent()
              .buildAppBarWithBackbutton('Rekod Kehadiran', context),
          body: SingleChildScrollView(
            child: Padding(
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
                  FutureBuilder(
                      future: ActivityController().countsOfPesertaInADate(
                          activity.activityID, dateChosen.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.groups),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.0)),
                                      child: Text('Bilangan Penyertaan Peserta',
                                          style:
                                              KoroboriComponent().getTextStyle(
                                            fontSize: 12,
                                          ))),
                                  const Spacer(),
                                  MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.0)),
                                      child: Text(
                                        snapshot.data!.toString(),
                                        style: KoroboriComponent().getTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  buildAttendanceInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: Text(
                        'Senarai Penyertaan Peserta',
                        style: KoroboriComponent().getTextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  buildAttendanceSearch(context),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildAttendanceSearch(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1,
      height: 700,
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
      child: Column(children: [
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
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.characters,
                  controller: searchScout,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: KoroboriComponent().getTextStyle(
                          fontSize: 12,
                          style: FontStyle.italic,
                          color: Colors.black.withOpacity(0.25)),
                      hintText: 'Cari Scouty ID atau nama peserta'),
                )),
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
        Expanded(
            child: StreamBuilder(
                stream: ActivityController().listenToAttendanceRecord(
                    activity.activityID, dateChosen.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  snapshot.data!.removeWhere(
                      (item) => item['attendance_status'] == false);

                  snapshot.data!.sort((a, b) {
                    DateTime first = DateTime.parse(a['time']);
                    DateTime second = DateTime.parse(b['time']);
                    return second.compareTo(first);
                  });

                  return Builder(builder: (context) {
                    if (searchText.isNotEmpty) {
                      List<Map<String, dynamic>> attendanceFiltered =
                          snapshot.data!.where((element) {
                        return (element['user_fullname']
                                .toString()
                                .toLowerCase()
                                .contains(searchText.toLowerCase()) ||
                            element['user_scout_id']
                                .toString()
                                .toLowerCase()
                                .contains(searchText.toLowerCase()));
                      }).toList();

                      return ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            return buildAttendanceCard(
                                attendanceFiltered[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: attendanceFiltered.length);
                    } else {
                      return ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            return buildAttendanceCard(snapshot.data![index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: snapshot.data!.length);
                    }
                  });
                })),
      ]),
    );
  }

  Widget buildAttendanceCard(Map<String, dynamic> data) {
    print(data['user_role']);
    return Builder(builder: (context) {
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.08,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/logo_subkem_${data['user_subcamp']}.svg',
                height: 35,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: Text(
                          data['user_fullname'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: KoroboriComponent().getTextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                    MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: Text(
                          "${data['user_scout_id']}  |  ${data['user_role'] == 'officer' ? 'URUSETIA' : data['user_role'] == 'pemimpin' ? 'PEMIMPIN' : 'PKK'}  |  "
                          "${data['daerah']}",
                          style: KoroboriComponent().getTextStyle(fontSize: 10),
                        )),
                    Row(
                      children: [
                        const Icon(
                          Icons.done,
                          size: 10,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                                textScaler: const TextScaler.linear(1.0)),
                            child: Text(
                              '${DateFormat('HH:mm:ss').format(DateTime.parse(data['time']).add(const Duration(hours: 8)))} |  ${data['pic_scout_id']}', //K1 ID Urusetia
                              style: KoroboriComponent()
                                  .getTextStyle(fontSize: 10),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                  radius: 12,
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
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            textScaler:
                                                const TextScaler.linear(1.0)),
                                        child: Text(
                                          'Padam Kehadiran',
                                          style: KoroboriComponent()
                                              .getTextStyle(
                                                  fontWeight: FontWeight.bold),
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.0)),
                                      child: Text(
                                        'Adakah anda pasti anda ingin mengeluarkan peserta berikut daripada senarai kehadiran?',
                                        textAlign: TextAlign.center,
                                        style: KoroboriComponent().getTextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            textScaler:
                                                const TextScaler.linear(1.0)),
                                        child: Text(
                                          data['user_fullname'],
                                          style: KoroboriComponent()
                                              .getTextStyle(
                                                  fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        )),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            textScaler:
                                                const TextScaler.linear(1.0)),
                                        child: Text(
                                          data['user_scout_id'],
                                          style: KoroboriComponent()
                                              .getTextStyle(
                                                  fontWeight: FontWeight.w500),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                actions: [
                                  KoroboriComponent()
                                      .greyButton(context, 'Pasti', () {
                                    Navigator.of(context).pop(true);
                                  }),
                                  KoroboriComponent()
                                      .blueButton(context, 'Batal', () {
                                    Navigator.of(context).pop(false);
                                  })
                                ],
                              );
                            });

                        if (isDeleteConfirmed != null && isDeleteConfirmed) {
                          await ActivityController()
                              .removeAttendance(data['attendance_id']);
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 9,
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
          child: MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: TextFormField(
                textCapitalization: TextCapitalization.characters,
                textAlignVertical: TextAlignVertical.center,
                controller: scoutyID,
                focusNode: textFocusNode,
                onFieldSubmitted: (value) async {
                  try {
                    await ActivityController().addAttendance(
                        activity.activityID, dateChosen.id,
                        scoutyID: value);
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }

                  scoutyID.clear();
                  textFocusNode.requestFocus();
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.person),
                    hintStyle: KoroboriComponent().getTextStyle(
                        fontSize: 14,
                        style: FontStyle.italic,
                        color: Colors.black.withOpacity(0.25)),
                    hintText: 'Sila masukkan Scouty ID peserta'),
              ))),
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
                SvgPicture.asset(
                  activity.activityIcons,
                  height: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: Flexible(
                      child: Text(
                        activity.activityName.toUpperCase(),
                        overflow: TextOverflow.visible,
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.pin_drop),
                const SizedBox(
                  width: 10,
                ),
                MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: const Text("PANTAI AIR PAPAN, MERSING")),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(
                  width: 10,
                ),
                MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: Text(
                        "${DateFormat("dd MMMM").format(dateChosen.date)} ${getFormattedTime(dateChosen.startTime)} - ${getFormattedTime(dateChosen.endTime)}"))
              ],
            ),
            Row(
              children: [
                const Icon(Icons.workspace_premium),
                const SizedBox(
                  width: 10,
                ),
                MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: Text(
                        "SEKTOR ${activity.activitySector.toUpperCase()}")),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.account_circle),
                const SizedBox(
                  width: 10,
                ),
                MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: Flexible(
                      child: Text(
                        activity.activityPIC,
                        overflow: TextOverflow.visible,
                      ),
                    )),
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
