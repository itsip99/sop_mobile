import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class Logo {
  static Widget rounded1(
    BuildContext context,
    String imgPath,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: ConstantColors.primaryColor2,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width < 800) ? 20 : 60,
        vertical: (MediaQuery.of(context).size.height < 800) ? 10 : 30,
      ),
      child: Image.asset(
        imgPath,
        fit: BoxFit.cover,
        scale: 1.75,
      ),
    );
  }
}
