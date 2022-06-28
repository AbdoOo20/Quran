import 'package:flutter/material.dart';
import 'package:quran/models/tranlation.dart';
import 'package:quran/style.dart';

Widget translationTile({
  required int index,
  required final SurahTranslation surahTranslation,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Constants.kPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
              ),
              Positioned(
                left: 12,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Text(
                    surahTranslation.ayah,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  surahTranslation.arabicText,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: Colors.black, thickness: 1),
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(children: [
                    const TextSpan(
                        text: 'التَّفْسِيرُ: ',
                        style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.bold, color: Colors.black54)),
                    TextSpan(
                      text: surahTranslation.translation,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
