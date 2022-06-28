import 'package:flutter/material.dart';

import '../models/juz.dart';

Widget juzCustomTile({
  required final List<JuzAyahs> list,
  required final int index,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 3,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(list[index].ayahNumber.toString()),
        Text(
          list[index].ayahText.toString(),
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          list[index].surahName.toString(),
          textAlign: TextAlign.end,
        ),
      ],
    ),
  );
}
