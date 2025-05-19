import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class CustomCard {
  static Widget card(
    BuildContext context,
    double widthConfig,
    double heightConfig,
    AlignmentGeometry alignmentConfig,
    Color borderColor,
    Color backgroundColor,
    Color shadowColor,
    ScrollPhysics physicsConfig,
    List<Widget> children, {
    double borderWidth = 1.0,
    double radiusConfig = 20.0,
    double paddingConfig = 8,
    double marginConfig = 8,
    double verticalDivider = 8.0,
  }) {
    return Container(
      width: widthConfig,
      height: heightConfig,
      alignment: alignmentConfig,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(radiusConfig),
      ),
      padding: EdgeInsets.all(paddingConfig),
      margin: EdgeInsets.all(marginConfig),
      child: SingleChildScrollView(
        physics: physicsConfig,
        child: Wrap(
          runSpacing: verticalDivider,
          children: [...children],
        ),
      ),
    );
  }

  static Widget brief(
    BuildContext context,
    String title,
    String content, {
    bool isHorizontal = true,
    double padVertical = 4,
    double padHorizontal = 4,
  }) {
    if (isHorizontal) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: padVertical,
          horizontal: padHorizontal,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextThemes.normal,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: TextThemes.normal,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: padVertical,
          horizontal: padHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextThemes.normal,
              textAlign: TextAlign.start,
            ),
            Text(
              content,
              style: TextThemes.normal,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
    }
  }

  static Widget button(
    BuildContext context,
    Function func,
    double buttonWidth,
    double buttonHeigth,
    AlignmentGeometry textAlignment,
    String text,
    TextStyle style,
    Color buttonColor,
    double verticalPadding,
    double horizontalPadding,
    double radius,
  ) {
    return ElevatedButton(
      onPressed: () => func(),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Container(
        width: buttonWidth,
        height: buttonHeigth,
        alignment: textAlignment,
        child: Text(text, style: style),
      ),
    );
  }
}
