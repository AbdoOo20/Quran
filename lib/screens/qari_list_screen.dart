import 'package:flutter/material.dart';
import 'package:quran/models/qari.dart';
import 'package:quran/screens/audio_surah_screen.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/style.dart';
import 'package:quran/widgets/qari_custom_tile.dart';

class QariScreen extends StatefulWidget {
  const QariScreen({Key? key}) : super(key: key);

  @override
  State<QariScreen> createState() => _QariScreenState();
}

class _QariScreenState extends State<QariScreen> {
  ApiServices api = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Qari\'s'), centerTitle: true),
        body: SizedBox(
          height: sizeFromHeight(context, 1, hasAppBar: true),
          width: sizeFromWidth(context, 1),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<Qari>>(
                    future: api.getQariList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.connectionState == ConnectionState.active ||
                          snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return QariCustomTile(snapshot.data![index], () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AudioSurahScreen(
                                        qari: snapshot.data![index])),
                              );
                            });
                          },
                        );
                      }
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
