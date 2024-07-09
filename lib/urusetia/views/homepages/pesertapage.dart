import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/urusetia/views/peserta/aktivitipeserta.dart';

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
                    SizedBox(
                      height: 20,
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
                        hintText: 'Cari nama peserta'),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: FutureBuilder(
                  future: AuthController().getAllAccounts(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return buildPeserta(snapshot.data![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 1,
                          color: const Color.fromARGB(255, 217, 217, 217),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPeserta(Account peserta) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AktivitiPeserta(
                  //tak sure letak ape
                  )));
        },
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
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        peserta.userFullname.toUpperCase(),
                        style: KoroboriComponent().getTextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        maxLines: 2, // Allow text to wrap to a new line
                        overflow: TextOverflow.visible, // Handle overflow
                      ),
                      Text('${peserta.scoutyID}  |  PKK',
                          style: KoroboriComponent().getTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          )),
                    ],
                  ),
                ),
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
