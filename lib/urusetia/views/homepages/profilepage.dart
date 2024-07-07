import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                      // SvgPicture.asset( //Kad VIP
                      //   'assets/images/kad-vip.svg',
                      //   semanticsLabel: 'Kad VIP',
                      //   height: 500,
                      // ),

                      SvgPicture.asset(
                        //Kad Urusetia
                        'assets/images/kad-urusetia.svg',
                        semanticsLabel: 'Kad Urusetia',
                        height: 500,
                      ),

                      // SvgPicture.asset( //Kad Tekno
                      //   'assets/images/kad-tekno.svg',
                      //   semanticsLabel: 'Kad Tekno',
                      //   height: 500,
                      // ),

                      // SvgPicture.asset( //Kad Neuro
                      //   'assets/images/kad-neuro.svg',
                      //   semanticsLabel: 'Kad Neuro',
                      //   height: 500,
                      // ),

                      // SvgPicture.asset( //Kad Inviso
                      //   'assets/images/kad-inviso.svg',
                      //   semanticsLabel: 'Kad Inviso0202',
                      //   height: 500,
                      // ),

                      // SvgPicture.asset(
                      //   //Kad Kombat
                      //   //Kad Kombat
                      //   'assets/images/kad-kombat.svg',
                      //   semanticsLabel: 'Kad Kombat',
                      //   height: 500,
                      // ),
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
                      buildDisplayBox('Nombor Kad Pengenalan', account.icNo),
                      buildDisplayBox('Scouty ID', account.scoutyID),
                      buildDisplayBox('Subkem', account.subcamp),
                      buildDisplayBox('Nombor Keahlian', account.schoolCode),
                      buildDisplayBox('Nombor Kumpulan', account.schoolCode),
                      buildDisplayBox('Umur', account.schoolCode),
                      buildDisplayBox('Jantina', account.icNo),
                      buildDisplayBox('Kaum', account.icNo),
                      buildDisplayBox('Agama', account.icNo),
                      buildDisplayBox('Daerah', account.icNo),
                      buildDisplayBox('Kod Sekolah', account.schoolCode),
                      buildDisplayBox('Nama Sekolah', account.schoolCode),
                      buildDisplayBox(
                          'Nama Ibu / Bapa / Penjaga', account.role),
                      buildDisplayBox('Nombor Telefon Ibu / Bapa / Penjaga',
                          account.schoolCode),
                      const SizedBox(
                        height: 15,
                      ),
                      KoroboriComponent().blueButton(
                          'Log Keluar', () => AuthController().logout(context),
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: 50),
                      const SizedBox(
                        height: 20,
                      )
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
              shadows: const [
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
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: KoroboriComponent().getTextStyle(
                          color: Colors.black.withOpacity(0.2), fontSize: 12),
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
