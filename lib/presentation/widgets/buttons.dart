import 'package:flutter/material.dart';

class CustomButton {
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
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
