import 'package:flutter/services.dart';

class Formatter {
  /// Converts a string to title case (first letter of each word capitalized, rest lowercase).
  /// Example: 'hELLO wOrLd' becomes 'Hello World'
  static String toTitleCase(String text) {
    if (text.isEmpty) return text;

    // Split into words, trim whitespace, and filter out empty strings
    final words =
        text.split(' ').where((word) => word.trim().isNotEmpty).toList();

    // Process each word
    final result = <String>[];
    for (final word in words) {
      if (word.isEmpty) continue;
      result.add(
        word[0].toUpperCase() +
            (word.length > 1 ? word.substring(1).toLowerCase() : ''),
      );
    }

    return result.join(' ');
  }

  static String removeSpaces(String text) {
    return text.trim();
  }

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

  /// A text formatter that converts input to title case as the user types
  static TextInputFormatter get titleCaseFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;
      final text = toTitleCase(newValue.text);
      return TextEditingValue(text: text, selection: newValue.selection);
    });
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
