import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class CustomButton {
  static Widget normalButton({
    required BuildContext context,
    required String text,
    required Function func,
    required Color bgColor,
    TextStyle? textStyle,
    double height = 50,
  }) {
    return GestureDetector(
      onTap: () => func(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }

  static Widget primaryButton1({
    required BuildContext context,
    required String text,
    required Function func,
    required Color bgColor,
    required TextStyle textStyle,
    required Color shadowColor,
  }) {
    return ElevatedButton(
      onPressed: () => func(),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        maximumSize: Size(MediaQuery.of(context).size.width, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: shadowColor,
        elevation: 5,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  static Widget primaryButton2({
    required BuildContext context,
    required String text,
    required Function func,
    required Color bgColor,
    required TextStyle textStyle,
    required Color shadowColor,
    double height = 50,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: () => func(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 5,
              spreadRadius: 1,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: Builder(
          builder: (context) {
            if (isLoading) {
              if (Platform.isIOS) {
                return const CupertinoActivityIndicator(
                  color: ConstantColors.primaryColor2,
                  radius: 10,
                );
              } else {
                return const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: ConstantColors.primaryColor2,
                  ),
                );
              }
            } else {
              return Text(
                text,
                style: textStyle,
              );
            }
          },
        ),
      ),
    );
  }
}
