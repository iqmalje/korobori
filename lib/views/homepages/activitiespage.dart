import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';

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
            body: Padding(
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
                          borderRadius: BorderRadius.circular(5)),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bilangan Aktiviti Berjaya Dilengkapkan',
                                style: KoroboriComponent().getTextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 50,
                                height: 25,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFF0003),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Center(
                                  child: Text(
                                    '21 / 31',
                                    style: KoroboriComponent().getTextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                              'Peserta perlu menyelesaikan sekurang-kurangnya 25 aktiviti daripada 31 aktiviti untuk melayakkan peserta mendapat sijil aktiviti.',
                              style: KoroboriComponent()
                                  .getTextStyle(fontSize: 10))
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
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Cari nama aktiviti'),
                  Text(
                    'TODO : NANTI SELIT AKTIVITI SEMUA KAT SINI (BACKEND)',
                    style: KoroboriComponent().getTextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
