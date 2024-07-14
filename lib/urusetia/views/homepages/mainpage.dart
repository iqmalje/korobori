import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/activitycontroller.dart';
import 'package:korobori/models/subcampenum.dart';
import 'package:korobori/models/subcamps.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SubCamp> subcamps = [
    SubCamp(
        name: Subcamps.kombat,
        daerahs: 'PONTIAN, TANGKAK & BATU PAHAT',
        imageURL: 'assets/images/logo_subkem_kombat.svg',
        mainColor: const Color(0xFF0000FF),
        count: 0),
    SubCamp(
        name: Subcamps.tekno,
        daerahs: 'PONTIAN, TANGKAK & BATU PAHAT',
        imageURL: 'assets/images/logo_subkem_tekno.svg',
        mainColor: const Color(0xFFFF0003),
        count: 0),
    SubCamp(
        name: Subcamps.inviso,
        daerahs: 'PONTIAN, TANGKAK & BATU PAHAT',
        imageURL: 'assets/images/logo_subkem_inviso.svg',
        mainColor: const Color(0xFF3EAD16),
        count: 0),
    SubCamp(
        name: Subcamps.neuro,
        daerahs: 'PONTIAN, TANGKAK & BATU PAHAT',
        imageURL: 'assets/images/logo_subkem_neuro.svg',
        mainColor: const Color(0xFFFF8438),
        count: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KoroboriComponent().getPrimaryColor(),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: KoroboriComponent().buildAppBar(context, 'Utama'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.05),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            //Kad Kombat
                            'assets/images/logo_korobori.svg',
                            semanticsLabel: 'Logo Korobori',
                            height: 200,
                          ),
                          MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.0),
                            child: Text(
                              'KOROBORI JOHOR',
                              style: KoroboriComponent().getTextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.0),
                            child: Text(
                              'PENGAKAP KANAK-KANAK 2024',
                              style: KoroboriComponent().getTextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.0),
                            child: Text(
                              '22 - 25 JUN | PANTAI AIR PAPAN, MERSING',
                              style: KoroboriComponent().getTextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: ActivityController().listenToAttendanceCount(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        for (var subcamp in subcamps) {
                          int index = snapshot.data!.indexWhere((element) =>
                              element['subcamp_name'] == subcamp.name.name);
                          int attendanceCount = snapshot.data![index]['count'];

                          subcamp.count = attendanceCount;
                        }

                        return Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(textScaleFactor: 1.0),
                                child: Text(
                                  'Prestasi Subkem Korobori 2024',
                                  style: KoroboriComponent().getTextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 10),
                                  itemCount: subcamps.length,
                                  itemBuilder: (context, index) =>
                                      buildSubCamps(subcamps[index]),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 15,
                                    );
                                  },
                                ),
                              ),
                              MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(textScaleFactor: 1.0),
                                child: Text(
                                  'Kemaskini : ${DateFormat('dd/MM/yy, HH:mm:ss').format(DateTime.now())}',
                                  style: KoroboriComponent()
                                      .getTextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        );
                      }),
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

  Widget buildSubCamps(SubCamp subCamp) {
    return Container(
      height: 60,
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              subCamp.imageURL,
              height: 55,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: Text(
                      "SUBKEM ${subCamp.name.name.toUpperCase()}",
                      style: KoroboriComponent().getTextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 1),
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: Text(
                      subCamp.daerahs,
                      style: KoroboriComponent().getTextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Container(
                height: 30,
                decoration: ShapeDecoration(
                  color: subCamp.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Center(
                    child: Text(
                      '${subCamp.count} / 500',
                      style: KoroboriComponent().getTextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
