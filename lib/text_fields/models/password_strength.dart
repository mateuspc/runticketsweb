import 'package:flutter/material.dart';

class PasswordStrength {
  Color color;
  String text;
  bool current;
  bool selected;

  PasswordStrength({required this.color,
    required this.text,
    required this.current,
    required this.selected});
}