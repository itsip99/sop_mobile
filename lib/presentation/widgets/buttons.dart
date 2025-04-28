import 'package:flutter/material.dart';

class CustomButton {
  static Widget primaryButton({
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
}
