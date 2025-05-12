import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class Loading {
  static Widget platformIndicator({
    double iosRadius = 2.5,
    Color iosCircleColor = ConstantColors.primaryColor1,
    double androidWidth = 20,
    double androidHeight = 20,
    double androidStrokeWidth = 2.5,
    Color androidCircleColor = ConstantColors.primaryColor1,
  }) {
    if (Platform.isIOS) {
      return iOS(
        radiusConfig: iosRadius,
        circleColor: iosCircleColor,
      );
    } else {
      return android(
        widthConfig: androidWidth,
        heightConfig: androidHeight,
        strokeConfig: androidStrokeWidth,
        circleColor: androidCircleColor,
      );
    }
  }

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

  static Widget iOS({
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
