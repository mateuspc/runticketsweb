import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/views/app_fonts.dart';
import '../enums/input_text_state_enum.dart';
import '../enums/password_strength_enum.dart';
import '../text_style/input_text_colors.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';

Row labelTopAndErrorTextFieldStr(
    {required String label,
      TypePasswordStrength? typePasswordStrength,
      bool forceNotShowForcaSenha = false,
      bool errorTop = false,
      bool confirmPassword = false,
    required String errorText}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(fontSize: 14.sp,
               fontWeight: FontWeight.w500,
               color: InputTextColors.colorGrey600,
               fontFamily: FontsApp.epilogueMedium
            ),
          ),
        ),
      ),
      const Spacer(),
      if (errorText.isNotEmpty && errorTop)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorText,
              style:  TextStyle(
                color: InputTextColors.colorError,
                fontWeight: FontWeight.bold,
                fontSize: InputTextFontSize.fontSizeErrorTextField,
              ),
            ),
          ),
        ) else if(forceNotShowForcaSenha) Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color: getColorIndicatorStrength(typePasswordStrength
                ?? TypePasswordStrength.none),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            child: Center(
              child: Text(
                getTextPasswordStrength(typePasswordStrength ?? TypePasswordStrength.none),
                style:  TextStyle(
                  color: InputTextColors.colorWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: InputTextFontSize.fontSizeText,
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

String getTextPasswordStrength(TypePasswordStrength typePasswordStrength) {
  switch(typePasswordStrength){

    case TypePasswordStrength.weak:
      return 'Fraca';
    case TypePasswordStrength.medium:
      return 'Média';
    case TypePasswordStrength.strong:
      return 'Forte';
    case TypePasswordStrength.none:
      return '';
  }
}

Color getColorIndicatorStrength(TypePasswordStrength typePasswordStrength) {
  switch(typePasswordStrength){

    case TypePasswordStrength.weak:
      return Colors.red;
    case TypePasswordStrength.medium:
      return Colors.amber;
    case TypePasswordStrength.strong:
      return Colors.green;
    case TypePasswordStrength.none:
      return Colors.transparent;
  }
}

Row labelTopAndErrorTextField(
    {required String label, required TypeTextFieldState statusTextField}) {
  return Row(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ),
      const Spacer(),
      if (statusTextField != TypeTextFieldState.valided)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              InputUtils.getTextMessageError(statusTextField),
              style:  TextStyle(
                color: InputTextColors.colorError,
                fontWeight: FontWeight.bold,
                fontSize: InputTextFontSize.fontSizeErrorTextField,
              ),
            ),
          ),
        )
    ],
  );
}
