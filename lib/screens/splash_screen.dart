import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran/screens/main_screen.dart';
import 'package:quran/screens/on_boarding_screen.dart';
import 'package:quran/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool watched = false;

  void getWatched() async {
    final prefs = await SharedPreferences.getInstance();
    watched = prefs.getBool('watched') ?? false;
  }

  @override
  void initState() {
    getWatched();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    watched ? const MainScreen() : const OnBoardingScreen(),
              ),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: sizeFromHeight(context, 1, hasAppBar: false),
          width: sizeFromWidth(context, 1),
          child: Stack(
            children: [
              const Center(
                  child: Text(
                'Muslim Soul',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset('assets/images/islamic.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
