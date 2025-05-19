import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class CustomSnackbar {
  static void showSnackbar(
    BuildContext context,
    String message, {
    double margin = 12.0,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double radius = 16.0,
    Color? backgroundColor,
    Color iconColor = ConstantColors.primaryColor3,
    bool showCloseIcon = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackbar.type1(
        margin,
        behavior,
        radius,
        message,
        backgroundColor ?? ConstantColors.shadowColor.shade300,
        iconColor,
        showCloseIcon,
      ),
    );
  }

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
