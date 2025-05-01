import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class FilterButton {
  static Widget iconOnly() {
    return Container(
      width: 35,
      height: 35,
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
  ) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: ConstantColors.shadowColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () => func(),
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Text(
            text,
            style: TextThemes.normalTextButton,
          ),
        ),
      ),
    );
  }
}
