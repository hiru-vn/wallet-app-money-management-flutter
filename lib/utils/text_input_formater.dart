import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight = newValue.text.length - newValue.selection.end;
      final f = new NumberFormat("#,###");
      int num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(num);
      return new TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

String textToCurrency(String text) {
  bool isNegative = false;
  if (text.contains('-')) isNegative=true; 
  int number = int.parse(text.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll('[^\\d.]', ''));
  if (!isNegative)
    return NumberFormat("#,###").format(number);
  return "- "+NumberFormat("#,###").format(number);
}

int currencyToInt(String text) {
  return int.parse(text.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll('[^\\d.]', ''));
}