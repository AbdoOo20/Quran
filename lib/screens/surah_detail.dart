import 'package:flutter/material.dart';
import 'package:quran/models/tranlation.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/style.dart';
import 'package:quran/widgets/custom_translation.dart';

class SurahDetail extends StatefulWidget {
  String surahName;
  SurahDetail(this.surahName,{Key? key}) : super(key: key);

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
  ApiServices api = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,title: Text(widget.surahName),centerTitle: true),
        body: FutureBuilder<SurahTranslationList>(
          future: api.getTranslation(Constants.surahIndex!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active ||
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.translationList.length,
                itemBuilder: (context, index) {
                  return translationTile(
                    index: index,
                    surahTranslation: snapshot.data!.translationList[index],
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
