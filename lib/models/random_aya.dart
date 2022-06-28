class AyaOfTheDay {
  final String arabicAya;
  final String englishAya;
  final String surahEnglishName;
  final int surahNumber;

  AyaOfTheDay({
    required this.arabicAya,
    required this.englishAya,
    required this.surahEnglishName,
    required this.surahNumber,
  });

  factory AyaOfTheDay.fromJSON(Map<String, dynamic> json) {
    return AyaOfTheDay(
      arabicAya: json['data'][0]['text'],
      englishAya: json['data'][2]['text'],
      surahEnglishName: json['data'][2]['surah']['englishName'],
      surahNumber: json['data'][2]['numberInSurah'],
    );
  }
}
