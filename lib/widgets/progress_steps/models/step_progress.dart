

import 'package:flutter/material.dart';

class StepData {
  final int stepIndex;
  final String stepText;
  final String labelText;

  StepData({
    required this.stepIndex,
    required this.stepText,
    required this.labelText,
  });

  bool showLineLeft() {
    return stepIndex > 1;
  }

  bool showLineRight(int stepsLength) {
    return stepIndex < stepsLength;
  }

  Color getBorderColor(int currentStep) {
    return currentStep >= int.parse(stepText)  ? Colors.green
        : Colors.grey[200] as Color;
  }
}
