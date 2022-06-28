import 'package:flutter/material.dart';
import 'package:quran/models/qari.dart';
import 'package:quran/models/surah.dart';
import 'package:quran/screens/audio_screen.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/widgets/audio_tile.dart';

class AudioSurahScreen extends StatefulWidget {
  final Qari qari;

  const AudioSurahScreen({Key? key, required this.qari}) : super(key: key);

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {
  ApiServices api = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.qari.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Surah>>(
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
                itemBuilder: (context, index) {
                  return audioTile(
                    surahName: snapshot.data![index].englishName,
                    totalAyah: snapshot.data![index].numberOfAyahs,
                    number: snapshot.data![index].number,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioScreen(
                              qari: widget.qari,
                              index: index + 1,
                              list: surah,
                            ),
                          ));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
