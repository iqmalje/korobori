import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/providers/accountprovider.dart';
import 'package:korobori/urusetia/views/authentication/login.dart';
import 'package:provider/provider.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  TextEditingController pengenalanController = TextEditingController(),
      namaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Account account = context.read<AccountProvider>().getAccount()!;

    return Material(
      color: KoroboriComponent().getPrimaryColor(),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: KoroboriComponent()
              .buildAppBarWithBackbutton('Padam Akaun', context),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.08),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: Text(
                          'Untuk memulakan pemadaman akaun anda, sila lengkapkan maklumat yang diminta di bawah.',
                          style: KoroboriComponent().getTextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                                textScaler: const TextScaler.linear(1.0)),
                            child: Text(
                              'Nombor Kad Pengenalan',
                              style: KoroboriComponent().getTextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    KoroboriComponent()
                        .buildInput(context, pengenalanController,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: KoroboriComponent().getPrimaryColor(),
                            ),
                            keyboardType: TextInputType.number,
                            //onSubmit: (_) async => await logIn(),
                            hintText: 'Nombor Kad Pengenalan'),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                              textScaler: const TextScaler.linear(1.0)),
                          child: Expanded(
                            child: Text(
                              'Nama Penuh seperti Kad Pengenalan',
                              style: KoroboriComponent().getTextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    KoroboriComponent().buildInput(context, namaController,
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: KoroboriComponent().getPrimaryColor(),
                        ),

                        //onSubmit: (_) async => await logIn(),
                        hintText: 'Nama Penuh seperti Kad Pengenalan'),
                    const SizedBox(
                      height: 20,
                    ),
                    KoroboriComponent().blueButton(
                      context,
                      'Padam Akaun',
                      () async {
                        if (pengenalanController.text.isEmpty ||
                            namaController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sila isi semua maklumat.')));
                          return;
                        } else {
                          //await AuthController().accountDeletion();
                          Account account =
                              context.read<AccountProvider>().account!;

                          if (pengenalanController.text != account.icNo ||
                              namaController.text != account.userFullname) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Maklumat diisi tidak tepat, sila cuba lagi')));
                            return;
                          }

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
                                            'Padam Akaun',
                                            style: KoroboriComponent()
                                                .getTextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            textScaler:
                                                const TextScaler.linear(1.0)),
                                        child: Text(
                                          'Adakah anda pasti anda ingin memadam akaun anda?',
                                          textAlign: TextAlign.center,
                                          style:
                                              KoroboriComponent().getTextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
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
                            await AuthController().accountDeletion();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (_) => true);
                          }
                        }
                      },
                      width: MediaQuery.sizeOf(context).width * 1,
                      height: 50,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
