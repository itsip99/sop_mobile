import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/cubit/sales.dart';

class CustomDropdown {
  static Widget sales(
    SalesStatusCubit cubit,
    List<String> items,
    String labelText, {
    double maxHeight = 200,
    double iconSize = 24,
    Color iconColor = ConstantColors.shadowColor,
    double radius = 20,
    double itemRadius = 20,
    Color borderColor = ConstantColors.primaryColor3,
    double horizontalPadding = 20,
    double verticalPadding = 12,
  }) {
    // ['Sales Counter', 'Freelance', 'Gold', 'Platinum']
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<String>(
        value: cubit.getSalesStatus(),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            // selectedStatus = value;
            cubit.setSalesStatus(value);
          }
        },
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: iconColor,
        ),
        iconSize: iconSize,
        hint: Text('Select ${labelText.toLowerCase()}'),
        menuMaxHeight: maxHeight,
        borderRadius: BorderRadius.circular(radius),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(itemRadius),
            borderSide: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
