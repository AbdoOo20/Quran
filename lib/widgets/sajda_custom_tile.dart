import 'package:flutter/material.dart';
import 'package:quran/style.dart';
import '../models/sajda.dart';

Widget sajdaCustomTile(SajdaAyah sajdaAyah, context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 3.0,
      ),
    ]),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Text(
                sajdaAyah.juzNumber.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: sizeFromWidth(context, 20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '${sajdaAyah.surahEnglishName} \n',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: sajdaAyah.revelationType,
                        style: const TextStyle(color: Colors.black)),
                  ]),
                ),
                SizedBox(width: sizeFromWidth(context, 20)),
              ],
            ),
            const Spacer(),
            Text(
              sajdaAyah.surahName,
              style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ],
    ),
  );
}
