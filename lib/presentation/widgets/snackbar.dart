import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class CustomSnackbar {
  static SnackBar type1(
    double margin,
    SnackBarBehavior behave,
    double radius,
    String text,
    Color color,
    Color iconColor,
    bool showCloseIcon,
  ) {
    return SnackBar(
      margin: EdgeInsets.all(margin),
      behavior: behave,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      content: Text(
        text,
        style: TextThemes.subtitle,
      ),
      backgroundColor: color,
      showCloseIcon: showCloseIcon,
      closeIconColor: iconColor,
    );
  }
}
