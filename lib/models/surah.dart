
class Surah {
  int number;
  String arabicName;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  String revelationType;

  Surah({
    required this.number,
    required this.arabicName,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory Surah.fromJSON(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      arabicName: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}
