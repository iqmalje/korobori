import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/providers/accountprovider.dart';
import 'package:korobori/urusetia/views/peserta/aktivitipeserta.dart';
import 'package:provider/provider.dart';

class PesertaPagePemimpin extends StatefulWidget {
  const PesertaPagePemimpin({super.key});

  @override
  State<PesertaPagePemimpin> createState() => _PesertaPagePemimpinState();
}

class _PesertaPagePemimpinState extends State<PesertaPagePemimpin> {
  String textSearch = "";
  TextEditingController search = TextEditingController();
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
                    KoroboriComponent().buildInput(search, width: 0, height: 40,
                        onChange: (text) {
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
                        hintText: 'Cari scouty ID atau nama peserta'),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: FutureBuilder(
                  future: AuthController().getAllAccounts(
                      subcamp:
                          context.read<AccountProvider>().account!.subcamp),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Builder(builder: (context) {
                      List<Account> pesertas = snapshot.data!.where((element) {
                        return (element.userFullname
                                .toLowerCase()
                                .contains(textSearch.toLowerCase()) ||
                            element.scoutyID
                                .toLowerCase()
                                .contains(textSearch.toLowerCase()));
                      }).toList();

                      if (textSearch.isNotEmpty) {
                        print("PATUT KAT SINI");
                        return ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return buildPeserta(pesertas[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 1,
                              color: const Color.fromARGB(255, 217, 217, 217),
                            );
                          },
                          itemCount: pesertas.length,
                        );
                      } else {
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
                      }
                    });
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
              builder: (context) => AktivitiPeserta(
                    account: peserta,
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
                      Text('${peserta.scoutyID}  |  ${peserta.role}',
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
                    decoration: BoxDecoration(
                      color: peserta.sijilApproved
                          ? const Color(0xFF3BE542)
                          : const Color(0xFFD9D9D9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      peserta.sijilApproved ? Icons.done : Icons.close,
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
