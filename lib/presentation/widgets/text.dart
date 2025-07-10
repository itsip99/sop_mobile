import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class CustomText {
  static Widget normal({required String text, TextStyle? themes}) {
    return Text(text, style: themes ?? TextThemes.normal);
  }

  static Widget title({required String text}) {
    return Text(text, style: TextThemes.title1);
  }

  static Widget subtitle({
    required String text,
    TextStyle themes = TextThemes.subtitle,
  }) {
    return Text(text, style: themes);
  }

  static Widget footer({required String text}) {
    return Text(text, style: TextThemes.normal);
  }

  static Widget footerButton({
    required Function pressedFunc,
    required String text,
  }) {
    return GestureDetector(
      onTap: () => pressedFunc(),
      child: Text(text, style: TextThemes.styledTextButton),
    );
  }

  static Widget horizontalAlignment(
    String sectionName, {
    String sectionValue = '',
    bool isIcon = false,
    IconData? icon,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: ConstantColors.lightShadowColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sectionName, style: TextThemes.normal),

            Builder(
              builder: (context) {
                if (isIcon) {
                  return Icon(icon, color: ConstantColors.primaryColor3);
                } else {
                  return Text(sectionValue, style: TextThemes.normal);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
