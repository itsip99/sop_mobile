import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class Loading {
  static Widget android({
    double widthConfig = 20,
    double heightConfig = 20,
    double strokeConfig = 2.5,
    Color circleColor = ConstantColors.primaryColor1,
  }) {
    return Center(
      child: SizedBox(
        width: widthConfig,
        height: heightConfig,
        child: CircularProgressIndicator(
          color: circleColor,
          strokeWidth: strokeConfig,
        ),
      ),
    );
  }

  static Widget ios({
    double radiusConfig = 2.5,
    Color circleColor = ConstantColors.primaryColor1,
  }) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: radiusConfig,
        color: circleColor,
      ),
    );
  }
}
