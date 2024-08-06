import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/views/app_colors.dart';
import '../../core/views/app_fonts.dart';
import 'input_text_colors.dart';

TextStyle styleTextFieldTextTyped({bool enabled = true}) {
  return TextStyle(
      fontSize: 16.sp,
      color: enabled ? InputTextColors.colorGreyHint : AppColors.midleGray,
      fontWeight: FontWeight.w600,
      fontFamily: FontsApp.epilogueMedium
  );
}

