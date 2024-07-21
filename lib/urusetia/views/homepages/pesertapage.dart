import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/urusetia/views/peserta/aktivitipeserta.dart';
import 'package:pagination_view/pagination_view.dart';

class PesertaPage extends StatefulWidget {
  const PesertaPage({super.key});

  @override
  State<PesertaPage> createState() => _PesertaPageState();
}

class _PesertaPageState extends State<PesertaPage> {
  String textSearch = "";
  TextEditingController search = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Account> accounts = [];
  int range = 50;
  int start = 0, end = 0;
  bool loaded = false;
  @override
  void initState() {
    end = start + range - 1;
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        start = end + 1;
        end += range - 1;
        loaded = false;
        fetchAccounts(start, end).then((value) => setState(() {
              accounts += value;
              accounts.sort((a, b) {
                return a.scoutyID.compareTo(b.scoutyID);
              });
              loaded = true;
              removeDuplicates();
            }));
      }
    });

    WidgetsFlutterBinding.ensureInitialized();
    fetchAccounts(start, end).then((value) => setState(() {
          accounts = value;
          accounts.sort((a, b) {
            return a.scoutyID.compareTo(b.scoutyID);
          });
          loaded = true;
          removeDuplicates();
        }));
  }

  Future<List<Account>> fetchAccounts(int start, int end) async {
    return AuthController().getAllAccounts(start: start, end: end);
  }

  Future<void> fetchSpecificAccount(String search) async {
    var accounts = await AuthController().searchAccount(search);
    print(accounts.length);
    setState(() {
      this.accounts += accounts;

      removeDuplicates();
    });
  }

  void removeDuplicates() {
    List<Account> accountTemp = [];
    var uniqueIDs = accounts.map((e) => e.accountID).toSet();

    for (var id in uniqueIDs) {
      accountTemp
          .add(accounts.firstWhere((element) => element.accountID == id));
    }

    accounts = accountTemp;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KoroboriComponent().getPrimaryColor(),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: KoroboriComponent().buildAppBar(context, 'Peserta'),
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
                    KoroboriComponent().buildInput(context, search, width: 0,
                        onChange: (text) {
                      setState(() {
                        textSearch = text;
                      });
                    }, onSubmit: (p0) async {
                      await fetchSpecificAccount(p0);
                    },
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
                        hintText: 'Cari scouty ID atau nama peserta'),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (!loaded) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Builder(builder: (context) {
                      List<Account> pesertas = accounts.where((element) {
                        return (element.userFullname
                                .toLowerCase()
                                .contains(textSearch.toLowerCase()) ||
                            element.scoutyID
                                .toLowerCase()
                                .contains(textSearch.toLowerCase()));
                      }).toList();

                      if (textSearch.isNotEmpty) {
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
                            return buildPeserta(accounts[index]);
                          },
                          controller: scrollController,
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 1,
                              color: const Color.fromARGB(255, 217, 217, 217),
                            );
                          },
                          itemCount: accounts.length,
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
                      MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                              textScaler: const TextScaler.linear(1.0)),
                          child: Text(
                            peserta.userFullname.toUpperCase(),
                            style: KoroboriComponent().getTextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            maxLines: 2, // Allow text to wrap to a new line
                            overflow: TextOverflow.visible, // Handle overflow
                          )),
                      MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: Text('${peserta.scoutyID}  |  ${peserta.role}',
                            style: KoroboriComponent().getTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            )),
                      )
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
