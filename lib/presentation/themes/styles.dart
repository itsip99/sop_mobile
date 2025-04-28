import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class TextFontFamily {
  static const String poppins = 'Poppins';
  static const String montserrat = 'Montserrat';
  static const String roboto = 'Roboto';
  static const String inter = 'Inter';
}

class TextThemes {
  static const TextStyle title = TextStyle(
    fontFamily: TextFontFamily.roboto,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: ConstantColors.primaryColor2,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: TextFontFamily.roboto,
    fontSize: 16,
    color: ConstantColors.primaryColor2,
  );

  static const TextStyle body = TextStyle(
    fontFamily: TextFontFamily.roboto,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: ConstantColors.primaryColor2,
  );
}
