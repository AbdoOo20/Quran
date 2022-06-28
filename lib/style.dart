import 'package:flutter/material.dart';

class Constants {
  static const kPrimary = Color(0xff8a51d1);
  static const MaterialColor kSwatchColor = MaterialColor(
    0xff8a51d1,
    <int, Color>{
      50: Color(0xff9662d6),
      100: Color(0xffa174da),
      200: Color(0xffad85df),
      300: Color(0xffb997e3),
      400: Color(0xffc5a8e8),
      500: Color(0xffd0b9ed),
      600: Color(0xffdccbf1),
      700: Color(0xffe8dcf6),
      800: Color(0xfff3eefa),
      900: Color(0xffffffff),
    },
  );
  static int? juzIndex;
  static int? surahIndex;
}

double sizeFromHeight(BuildContext context, double fraction,
    {bool hasAppBar = true}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final calculateHeight = (hasAppBar
          ? (screenHeight -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top)
          : screenHeight) /
      fraction;
  return calculateHeight;
}

double sizeFromWidth(BuildContext context, double fraction) {
  final calculateWidth = MediaQuery.of(context).size.width / fraction;
  return calculateWidth;
}
