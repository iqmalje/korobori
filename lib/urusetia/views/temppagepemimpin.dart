import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/urusetia/views/homepages/activitiespagepemimpin.dart';
import 'package:korobori/urusetia/views/homepages/mainpage.dart';
import 'package:korobori/urusetia/views/homepages/pesertapagepemimpin.dart';
import 'package:korobori/urusetia/views/homepages/profilepage.dart';

class TempPagePemimpin extends StatefulWidget {
  const TempPagePemimpin({super.key});

  @override
  State<TempPagePemimpin> createState() => _TempPagePemimpinState();
}

class _TempPagePemimpinState extends State<TempPagePemimpin> {
  List<Widget> pages = [
    const MainPage(),
    const PesertaPagePemimpin(),
    const ActivitiesPagePemimpin(),
    const ProfilePage()
  ];
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentindex],
      bottomNavigationBar: buildNavBar(),
    );
  }

  Widget buildNavBar() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x28000000),
            blurRadius: 16,
            offset: Offset(0, -3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavButton(0, Icons.home, 'Utama'),
            buildNavButton(1, Icons.groups, 'Peserta'),
            buildNavButton(2, Icons.calendar_today, 'Aktiviti'),
            buildNavButton(3, Icons.person, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget buildNavButton(int indexPage, IconData icon, String title) {
    Color color;
    if (currentindex == indexPage) {
      color = KoroboriComponent().getPrimaryColor();
    } else {
      color = Colors.black.withOpacity(0.25);
    }
    return IconButton(
        onPressed: () {
          //ignores
          if (currentindex == indexPage) {
            return;
          } else {
            setState(() {
              currentindex = indexPage;
            });
          }
        },
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
            ),
            MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Text(
                  title,
                  style: KoroboriComponent()
                      .getTextStyle(color: color, fontSize: 10),
                ))
          ],
        ));
  }
}
