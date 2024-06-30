import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/models/subcamps.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SubCamp> subcamps = [
    SubCamp(
        name: 'SUBKEM KOMBAT',
        daerahs: 'PONTIAN, TANGKAK & BATU PAHAT',
        imageURL: 'assets/images/kombat_logo.png',
        mainColor: const Color(0xFF0000FF),
        count: 500),
    SubCamp(
        name: 'SUBKEM TEKNO',
        daerahs: 'PONTIAN, TANGKAK & BATU PAHAT',
        imageURL: 'assets/images/tekno_logo.png',
        mainColor: const Color(0xFFFF0003),
        count: 500),
    SubCamp(
        name: 'SUBKEM INVISO',
        daerahs: 'PONTIAN, TANGKAK & BATU PAHAT',
        imageURL: 'assets/images/inviso_logo.png',
        mainColor: const Color(0xFF3EAD16),
        count: 500),
    SubCamp(
        name: 'SUBKEM NEURO',
        daerahs: 'PONTIAN, TANGKAK & BATU PAHAT',
        imageURL: 'assets/images/neuro_logo.png',
        mainColor: const Color(0xFFFF8438),
        count: 500),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KoroboriComponent().getPrimaryColor(),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: KoroboriComponent().buildAppBar('Utama'),
          body: Padding(
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
                        Image.asset(
                          'assets/images/logo_korobori.png',
                          height: 130,
                        ),
                        Text(
                          'KOROBORI JOHOR',
                          style: KoroboriComponent().getTextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'PENGAKAP KANAK-KANAK 2024',
                          style: KoroboriComponent().getTextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '22 - 25 JUN | PANTAI AIR PAPAN, MERSING',
                          style: KoroboriComponent().getTextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Prestasi Subkem Korobori 2024',
                        style: KoroboriComponent().getTextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 10),
                          itemCount: subcamps.length,
                          itemBuilder: (context, index) =>
                              buildSubCamps(subcamps[index]),
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                        ),
                      ),
                      Text(
                        'Kemaskini : ${DateFormat('dd/MM/yy, hh:mm:ss').format(DateTime.now())}',
                        style: KoroboriComponent().getTextStyle(fontSize: 10),
                      ),
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
            Image.asset(subCamp.imageURL),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subCamp.name,
                  style: KoroboriComponent()
                      .getTextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 1),
                Text(
                  subCamp.daerahs,
                  style: KoroboriComponent()
                      .getTextStyle(fontWeight: FontWeight.w300, fontSize: 10),
                )
              ],
            ),
            Spacer(),
            Container(
              height: 30,
              decoration: ShapeDecoration(
                color: subCamp.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Center(
                  child: Text(
                    '${subCamp.count} / 500',
                    style: KoroboriComponent().getTextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
