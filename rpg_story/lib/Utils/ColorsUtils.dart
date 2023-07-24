import 'dart:math';
import 'package:flutter/material.dart';

Color generateColorFromString(String inputString) {
  final random = Random(inputString.hashCode);
  final red = random.nextInt(256);
  final green = random.nextInt(256);
  final blue = random.nextInt(256);
  return Color.fromARGB(255, red, green, blue);
}
