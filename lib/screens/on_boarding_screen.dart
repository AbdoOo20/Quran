
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quran/screens/main_screen.dart';
import 'package:quran/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  void setWatched() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('watched', true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: sizeFromHeight(context, 1, hasAppBar: false),
          width: sizeFromWidth(context, 1),
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: "Read Quran",
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Customize your reading view, read in multiple language, listen different audio.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                image: Center(
                    child: Image.asset('assets/images/quran.png',
                        fit: BoxFit.fitWidth)),
              ),
              PageViewModel(
                title: "Prayer Alerts",
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Choose your adhan, which prayer to be notified of and how often.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                image: Center(
                    child: Image.asset('assets/images/prayer.png',
                        fit: BoxFit.fitWidth)),
              ),
              PageViewModel(
                title: "Build Better Habits",
                bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Make Islamic practices a part of your daily life in a way that best suits your life",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                image: Center(
                    child: Image.asset('assets/images/zakat.png',
                        fit: BoxFit.fitWidth)),
              ),
            ],
            onDone: () {
              setWatched();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            },
            next: const Icon(Icons.arrow_forward),
            done: const Text("Done",
                style: TextStyle(fontWeight: FontWeight.bold)),
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Constants.kPrimary,
                color: Colors.grey,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
          ),
        ),
      ),
    );
  }
}
