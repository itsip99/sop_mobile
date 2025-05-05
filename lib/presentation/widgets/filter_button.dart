import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class FilterButton {
  static Widget iconOnly() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: ConstantColors.shadowColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.filter_list_alt,
        color: ConstantColors.primaryColor3,
      ),
    );
  }

  static Widget textButton(
    Function func,
    String text,
    bool isActive,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: () => func(),
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? ConstantColors.primaryColor1.withAlpha(130)
              : ConstantColors.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color:
                  isActive ? ConstantColors.primaryColor1 : Colors.transparent,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: Text(
          text,
          style: TextThemes.normalTextButton,
        ),
      ),
    );
  }

  static Widget dateButton(
    Function func,
    String text,
  ) {
    return Container(
      height: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ConstantColors.shadowColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () => func(),
        borderRadius: BorderRadius.circular(12),
        child: Text(
          text,
          style: TextThemes.normalTextButton,
        ),
      ),
    );
  }
}
