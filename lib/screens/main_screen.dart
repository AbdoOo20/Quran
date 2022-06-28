import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quran/screens/home_screen.dart';
import 'package:quran/screens/prayer_screen.dart';
import 'package:quran/screens/qari_list_screen.dart';
import 'package:quran/screens/quran_screen.dart';
import 'package:quran/style.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Widget> pages = const [
    HomeScreen(),
    QuranScreen(),
    QariScreen(),
    PrayerScreen(),
  ];

  void updateIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: Constants.kPrimary,
            activeColor: Constants.kPrimary,
            items: [
              TabItem(
                  icon: Image.asset('assets/images/home.png',
                      color: Colors.white),
                  title: 'Home'),
              TabItem(
                  icon: Image.asset('assets/images/holyQuran.png',
                      color: Colors.white),
                  title: 'Quran'),
              TabItem(
                  icon: Image.asset('assets/images/audio.png',
                      color: Colors.white),
                  title: 'Audio'),
              TabItem(
                  icon: Image.asset('assets/images/mosque.png',
                      color: Colors.white),
                  title: 'Prayer'),
            ],
            initialActiveIndex: 0,
            onTap: updateIndex,
          )),
    );
  }
}
