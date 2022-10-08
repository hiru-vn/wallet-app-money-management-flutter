import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue Value) {
    if (Value.text.length == 0) {
      return Value.copyWith(text: '');
    } else if (Value.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight = Value.text.length - Value.selection.end;
      final f = NumberFormat("#,###");
      int num = int.parse(Value.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final String = f.format(num);
      return TextEditingValue(
        text: String,
        selection: TextSelection.collapsed(
            offset: String.length - selectionIndexFromTheRight),
      );
    } else {
      return Value;
    }
  }
}

String textToCurrency(String text) {
  bool isNegative = false;
  if (text.contains('-')) isNegative = true;
  int number = int.parse(
      text.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll('[^\\d.]', ''));
  if (!isNegative) return NumberFormat("#,###").format(number);
  return "- " + NumberFormat("#,###").format(number);
}

int currencyToInt(String text) {
  return int.parse(
      text.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll('[^\\d.]', ''));
}
