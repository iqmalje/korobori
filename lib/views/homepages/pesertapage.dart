import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/models/account.dart';

class PesertaPage extends StatefulWidget {
  const PesertaPage({super.key});

  @override
  State<PesertaPage> createState() => _PesertaPageState();
}

class _PesertaPageState extends State<PesertaPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: KoroboriComponent().getPrimaryColor(),
      child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: KoroboriComponent().buildAppBar('Peserta'),
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
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 4, color: Colors.black.withOpacity(0.25))
                  ]),
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        color: const Color.fromARGB(255, 217, 217, 217),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return buildPeserta(Account(
                              accountID: 'takde',
                              scoutyID: 'takde',
                              schoolCode: 'takde',
                              subcamp: 'takde',
                              icNo: 'takde',
                              role: 'takde',
                              userFullname:
                                  'FIKRI AKMAL jfjsfjsfjksfsjfsjkjsvjksvjsjvsjbvj'));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 1,
                            color: const Color.fromARGB(255, 217, 217, 217),
                          );
                        },
                        itemCount: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget buildPeserta(Account peserta) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              children: [
                const Icon(Icons.account_circle),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Flexible(
                        child: Text(
                      peserta.userFullname.toUpperCase(),
                      style: KoroboriComponent().getTextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      maxLines: 2, // Allow text to wrap to a new line
                      overflow: TextOverflow.visible, // Handle overflow
                    )),
                    Text('K001  |  PESERTA',
                        style: KoroboriComponent().getTextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        )),
                  ],
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
                    decoration: BoxDecoration(
                      color: Color(
                          0xFF3BE542), //isCompleted ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
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
