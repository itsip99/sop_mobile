import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class CustomText {
  static Widget title({
    required String text,
  }) {
    return Text(
      text,
      style: TextThemes.title1,
    );
  }

  static Widget subtitle({
    required String text,
  }) {
    return Text(
      text,
      style: TextThemes.subtitle,
    );
  }

  static Widget footer({
    required String text,
  }) {
    return Text(
      text,
      style: TextThemes.normal,
    );
  }

  static Widget footerButton({
    required Function pressedFunc,
    required String text,
  }) {
    return GestureDetector(
      onTap: () => pressedFunc(),
      child: Text(
        text,
        style: TextThemes.textButton,
      ),
    );
  }
}
