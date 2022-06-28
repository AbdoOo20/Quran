import 'package:flutter/material.dart';
import 'package:quran/models/surah.dart';
import 'package:quran/screens/juz_screen.dart';
import 'package:quran/screens/surah_detail.dart';
import 'package:quran/widgets/surah_custom_tile.dart';

import '../models/sajda.dart';
import '../services/api_service.dart';
import '../style.dart';
import '../widgets/sajda_custom_tile.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  ApiServices api = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Quran',
                style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Text(
                  'Surah',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Sajda',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Juz',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: sizeFromHeight(context, 1, hasAppBar: false),
            width: sizeFromWidth(context, 1),
            child: TabBarView(
              children: <Widget>[
                FutureBuilder<List<Surah>>(
                  future: api.getSurah(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.active ||
                        snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List<Surah> surah = snapshot.data as List<Surah>;
                      return ListView.builder(
                        itemCount: surah.length,
                        itemBuilder: (context, index) => surahCustomListTile(
                          surah: surah[index],
                          context: context,
                          onTap: () {
                            setState(() {
                              Constants.surahIndex = (index + 1);
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SurahDetail(surah[index].arabicName)));
                          },
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder<SajdaList>(
                  future: api.getSajda(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView.builder(
                        itemCount: snapshot.data!.sajdaAyahs.length,
                        itemBuilder: (context, index) => sajdaCustomTile(
                            snapshot.data!.sajdaAyahs[index], context),
                      );
                    }
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            Constants.juzIndex = (index + 1);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JuzScreen(Constants.juzIndex)));
                        },
                        child: Card(
                          elevation: 0,
                          color: Colors.blueGrey,
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
