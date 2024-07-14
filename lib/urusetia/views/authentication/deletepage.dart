import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/providers/accountprovider.dart';
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
                            .copyWith(textScaleFactor: 1.0),
                        child: Text(
                          'Untuk memulakan pemadaman akaun anda, sila lengkapkan maklumat yang diminta di bawah.',
                          style: KoroboriComponent().getTextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.0),
                            child: Text(
                              'Nombor Kad Pengenalan',
                              style: KoroboriComponent().getTextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            )),
                      ],
                    ),
                    SizedBox(
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
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.0),
                          child: Text(
                            'Nama Penuh seperti Kad Pengenalan',
                            style: KoroboriComponent().getTextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
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
                      () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const DeletePage(),
                          ),
                          (_) => false),
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
