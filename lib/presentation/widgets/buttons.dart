import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';

class CustomButton {
  static Widget radioButton({
    required bool isSelected,
    required Function onSelect,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    return Radio<bool>(
      value: true,
      groupValue: isSelected,
      onChanged: (value) => onSelect(),
      activeColor: selectedColor,
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return selectedColor;
        }
        return unselectedColor;
      }),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

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
        child: Text(text, style: textStyle),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: shadowColor,
        elevation: 5,
      ),
      child: Text(text, style: textStyle),
    );
  }

  static Widget primaryButton2({
    required BuildContext context,
    String text = '',
    required Function func,
    required Color bgColor,
    double borderRadius = 20,
    required TextStyle textStyle,
    required Color shadowColor,
    double? width,
    double height = 50,
    bool isLoading = false,
    bool enableIcon = false,
    IconData? icon,
    double spreadRadius = 1,
  }) {
    return GestureDetector(
      onTap: () => func(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 5,
              spreadRadius: spreadRadius,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: Builder(
          builder: (context) {
            if (isLoading) {
              return Loading.platformIndicator(
                iosRadius: 13,
                iosCircleColor: ConstantColors.primaryColor3,
                androidWidth: 24,
                androidHeight: 24,
                androidStrokeWidth: 3.5,
                androidCircleColor: ConstantColors.primaryColor3,
              );
            } else {
              if (enableIcon) {
                return Icon(icon);
              } else {
                return Text(text, style: textStyle);
              }
            }
          },
        ),
      ),
    );
  }
}
