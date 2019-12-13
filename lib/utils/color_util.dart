import 'package:flutter/material.dart';
import 'package:wallet_exe/consts.dart';

Color valueToColor(int value) {
  for (Color color in colors) {
    if (value == color.value) {
      return color;
    }
  }

  return Color(value);
}
