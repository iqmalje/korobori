import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/models/account.dart';
import 'package:korobori/providers/accountprovider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Account account = context.read<AccountProvider>().getAccount()!;

    return Material(
      color: KoroboriComponent().getPrimaryColor(),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: KoroboriComponent().buildAppBar('Profil'),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Korobori Johor Digital ID',
                        style: KoroboriComponent()
                            .getTextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset('assets/images/example_card.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Maklumat Peserta',
                        style: KoroboriComponent()
                            .getTextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildDisplayBox('Nama Penuh', account.userFullname),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Nombor Kad Pengenalan', account.icNo),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Scouty ID', account.scoutyID),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Subkem', account.subcamp),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Nombor Keahlian', account.schoolCode),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Nombor Kumpulan', account.schoolCode),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Umur', account.schoolCode),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Jantina', account.icNo),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Kaum', account.icNo),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Agama', account.icNo),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Daerah', account.icNo),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Kod Sekolah', account.schoolCode),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Nama Sekolah', account.schoolCode),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox(
                          'Nama Ibu / Bapa / Penjaga', account.role),
                      const SizedBox(
                        height: 5,
                      ),
                      buildDisplayBox('Nombor Telefon Ibu / Bapa / Penjaga',
                          account.schoolCode),
                      const SizedBox(
                        height: 10,
                      ),
                      KoroboriComponent().blueButton(
                          'Log Keluar', () => AuthController().logout(context),
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: 50)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDisplayBox(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width -
                (MediaQuery.sizeOf(context).width * 0.2),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: KoroboriComponent().getTextStyle(
                          color: Colors.black.withOpacity(0.2), fontSize: 13),
                    ),
                    Text(content,
                        style: KoroboriComponent().getTextStyle(height: 1))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
