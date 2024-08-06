
import 'package:flutter/services.dart';

class UppercaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(), // Converte todas as letras para maiúsculas
      selection: newValue.selection,
    );
  }
}
