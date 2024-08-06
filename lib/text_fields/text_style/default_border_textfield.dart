import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'input_text_colors.dart';

OutlineInputBorder defaultOutlineBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusDefault),
      borderSide: const BorderSide(
        color: InputTextColors.colorGreyBorder
      )
  );
}
 double borderRadiusDefault = 8.r;