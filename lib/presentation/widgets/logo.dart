import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class Logo {
  static Widget rounded1(
    BuildContext context,
    String imgPath,
    double widthConfig,
    double heightConfig,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ConstantColors.primaryColor2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(
        imgPath,
        fit: BoxFit.contain,
        width: widthConfig,
        height: heightConfig,
      ),
    );
  }
}
