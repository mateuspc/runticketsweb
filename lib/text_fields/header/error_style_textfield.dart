import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/views/app_fonts.dart';
import '../text_style/input_text_colors.dart';

errorStyleTextField(){
  return  TextStyle(color: InputTextColors.colorError,
     fontSize: 14.sp,
     fontFamily: FontsApp.epilogueSemiBold
  );
}