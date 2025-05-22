import 'package:flutter/services.dart';

class Formatter {
  static String reformatDate(String date) {
    final parts = date.split('-');
    if (parts.length == 3) {
      return '${parts[2]}-${parts[1]}-${parts[0]}';
    }
    return date; // Return the original date if the format is incorrect
  }

  static dateCircleBracketFormatter(String text) {
    return text.replaceAll('(', '').replaceAll(')', '');
  }

  static dateFormatter(String text) {
    return text.split(' ')[0];
  }

  static TextInputFormatter get normalFormatter {
    return FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z 0-9./@]*$'));
  }

  static TextInputFormatter get numberFormatter {
    return FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'));
  }

  static TextInputFormatter get capitalFormatter {
    return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9/]'));
  }
}

class CapitalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final text = newValue.text.toUpperCase();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
