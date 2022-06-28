class JuzModel {
  final int juzNumber;
  final List<JuzAyahs> juzAyahs;

  JuzModel({
    required this.juzNumber,
    required this.juzAyahs,
  });

  factory JuzModel.fromJSON(Map<String, dynamic> json) {
    Iterable juzAyahs = json['data']['ayahs'];
    List<JuzAyahs> juzAyahsList =
        juzAyahs.map((e) => JuzAyahs.fromJSON(e)).toList();
    return JuzModel(
      juzNumber: json['data']['number'],
      juzAyahs: juzAyahsList,
    );
  }
}

class JuzAyahs {
  final String ayahText;
  final int ayahNumber;
  final String surahName;

  JuzAyahs({
    required this.ayahText,
    required this.ayahNumber,
    required this.surahName,
  });

  factory JuzAyahs.fromJSON(Map<String, dynamic> json) {
    return JuzAyahs(
      ayahText: json['text'],
      ayahNumber: json['number'],
      surahName: json['surah']['name'],
    );
  }
}
