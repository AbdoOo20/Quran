import 'dart:convert';
import 'dart:math';

import 'package:quran/models/juz.dart';
import 'package:quran/models/qari.dart';
import 'package:quran/models/random_aya.dart';
import 'package:http/http.dart' as http;
import 'package:quran/models/surah.dart';
import 'package:quran/models/tranlation.dart';

import '../models/sajda.dart';

class ApiServices {
  List<Surah> surah = [];
  List<Qari> qari = [];

  random(min, max) {
    var number = Random();
    return min + number.nextInt(max - min);
  }

  Future<AyaOfTheDay> getAyaOfTheDay() async {
    String url =
        'http://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Surah>> getSurah() async {
    final response =
        await http.get(Uri.parse('http://api.alquran.cloud/v1/surah'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      json['data'].forEach((element) {
        if (surah.length < 114) {
          surah.add(Surah.fromJSON(element));
        }
      });
      return surah;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<SajdaList> getSajda() async {
    String url = "http://api.alquran.cloud/v1/sajda/en.asad";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SajdaList.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed  to Load Post");
    }
  }

  Future<JuzModel> getJuz(int index) async {
    String url = 'http://api.alquran.cloud/v1/juz/$index/quran-uthmani';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return JuzModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<SurahTranslationList> getTranslation(int index) async {
    String url =
        'https://quranenc.com/api/v1/translation/sura/arabic_mokhtasar/$index';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SurahTranslationList.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Qari>> getQariList() async {
    final response =
        await http.get(Uri.parse('https://quranicaudio.com/api/qaris'));
    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((element) {
        if (qari.length < 157) {
          qari.add(Qari.fromJSON(element));
        }
      });
      qari.sort((a, b) => a.name.compareTo(b.name)); // sort from A to Z
      return qari;
    } else {
      throw Exception('Failed to load');
    }
  }
}
