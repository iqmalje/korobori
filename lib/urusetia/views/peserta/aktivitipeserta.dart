import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';

class AktivitiPeserta extends StatefulWidget {
  const AktivitiPeserta({super.key});

  @override
  State<AktivitiPeserta> createState() => _AktivitiPesertaState();
}

class _AktivitiPesertaState extends State<AktivitiPeserta> {
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    buildRekodPeserta(),
                    SizedBox(
                      height: 15,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    overflow:
                                        TextOverflow.visible, // Handle overflow
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
                                      '19 / 28',
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
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Peserta perlu menyelesaikan sekurang-kurangnya 20 aktiviti daripada 28 aktiviti untuk melayakkan peserta mendapat sijil aktiviti.',
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
            )));
  }

  Container buildRekodPeserta() {
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
                Icon(Icons.account_circle),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "jcnasjcjascjasbvjbasjvbbvajvbjbvsjbj",
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.badge),
                SizedBox(
                  width: 10,
                ),
                Text("K001"),
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
                    "SK BUKIT KUARI",
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
}
