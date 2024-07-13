import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/models/activity.dart';

class AktivitiPeserta extends StatefulWidget {
  final Account account;
  const AktivitiPeserta({super.key, required this.account});

  @override
  State<AktivitiPeserta> createState() => _AktivitiPesertaState(account);
}

class _AktivitiPesertaState extends State<AktivitiPeserta> {
  Account account;
  String textSearch = "";
  TextEditingController search = TextEditingController();
  _AktivitiPesertaState(this.account);
  @override
  Widget build(BuildContext context) {
    return Material(
        color: KoroboriComponent().getPrimaryColor(),
        child: SafeArea(
            bottom: false,
            child: Scaffold(
              appBar: KoroboriComponent()
                  .buildAppBarWithBackbutton('Rekod Peserta', context),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.08),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future:
                              AuthController().getAccount(account.accountID),
                          builder: (context, snapshot) {
                            print(account.accountID);
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return buildRekodPeserta(snapshot.data!);
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                          future: ActivityController()
                              .getAttendances(account.accountID),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildAttendCount(snapshot.data!.length),
                                const SizedBox(
                                  height: 15,
                                ),
                                KoroboriComponent().buildInput(search,
                                    width: 0, height: 40, onChange: (text) {
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  child: Builder(builder: (context) {
                                    if (textSearch.isNotEmpty) {
                                      List<Activity> activitiesFiltered =
                                          snapshot.data!
                                              .where((element) => element
                                                  .activityName
                                                  .toLowerCase()
                                                  .contains(
                                                      textSearch.toLowerCase()))
                                              .toList();
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return buildActivity(
                                              activitiesFiltered[index]);
                                        },
                                        itemCount: activitiesFiltered.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                      );
                                    } else {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return buildActivity(
                                              snapshot.data![index]);
                                        },
                                        itemCount: snapshot.data!.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                      );
                                    }
                                  }),
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
            )));
  }

  Container buildAttendCount(int count) {
    return Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Bilangan Aktiviti Berjaya Dilengkapkan',
                    style: KoroboriComponent().getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2, // Allow text to wrap to a new line
                    overflow: TextOverflow.visible, // Handle overflow
                  ),
                ),
                Container(
                  width: 50,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: count >= 20
                        ? const Color(0xFF3BE542)
                        : const Color(0xFFFF0003),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$count / 28',
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
            const SizedBox(
              height: 5,
            ),
            Text(
              'Peserta perlu menyelesaikan sekurang-kurangnya 20 aktiviti daripada 28 aktiviti untuk melayakkan peserta mendapat sijil aktiviti.',
              style: KoroboriComponent().getTextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Container buildRekodPeserta(Account peserta) {
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
                const Icon(Icons.account_circle),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    peserta.userFullname,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.badge),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    "${account.scoutyID}  |  ${account.subcamp.toUpperCase()}"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.home),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "${peserta.schoolCode} |  ${peserta.school!.schoolName}",
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

  Widget buildActivity(Activity activity) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 50,
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
