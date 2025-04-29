import 'package:flutter/services.dart';

class Formatter {
  static TextInputFormatter get normalFormatter {
    return FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z 0-9./@]*$'));
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
