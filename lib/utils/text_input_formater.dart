import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue value) {
    if (value.text.length == 0) {
      return value.copyWith(text: '');
    } else if (value.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight = value.text.length - value.selection.end;
      final f = NumberFormat("#,###");
      int num = int.parse(value.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final _string = f.format(num);
      return TextEditingValue(
        text: _string,
        selection: TextSelection.collapsed(
            offset: _string.length - selectionIndexFromTheRight),
      );
    } else {
      return value;
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
