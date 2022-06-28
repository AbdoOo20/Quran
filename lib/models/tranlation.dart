class SurahTranslationList {
  final List<SurahTranslation> translationList;

  SurahTranslationList({required this.translationList});

  factory SurahTranslationList.fromJSON(Map<String, dynamic> json) {
    Iterable translation = json['result'];
    List<SurahTranslation> list =
        translation.map((e) => SurahTranslation.fromJSON(e)).toList();
    return SurahTranslationList(translationList: list);
  }
}

class SurahTranslation {
  String surah;
  String ayah;
  String arabicText;
  String translation;

  SurahTranslation({
    required this.surah,
    required this.ayah,
    required this.arabicText,
    required this.translation,
  });

  factory SurahTranslation.fromJSON(Map<String, dynamic> json) {
    return SurahTranslation(
      surah: json['sura'],
      ayah: json['aya'],
      arabicText: json['arabic_text'],
      translation: json['translation'],
    );
  }
}
