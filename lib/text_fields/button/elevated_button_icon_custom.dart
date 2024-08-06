import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../text_style/fonts_text_fields.dart';
import '../text_style/input_text_colors.dart';
import '../utils/build_svg_icon.dart';

class ElevatedButtonCustomIcon extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final bool enabled;
  final String? pathSvgIcon;

  const ElevatedButtonCustomIcon({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = InputTextColors.colorWhite,
    this.color = InputTextColors.colorPrimary,
    this.pathSvgIcon,
    this.iconColor = InputTextColors.colorWhite,
    this.enabled = true,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 50.w,
      child: ElevatedButton.icon(
        onPressed: enabled ? () {
          HapticFeedback.mediumImpact();
          onPressed();
        } : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
          backgroundColor: enabled ?
          color :
          InputTextColors.colorGrey300,
        ),
        icon: isLoading ? null : pathSvgIcon != null ? buildSvgIconModuleTextFields(pathSvgIcon!,
        color: iconColor) : null,
        label: isLoading ?  CircularProgressIndicator(
          color: iconColor,
        ) :
        Text(text,
          style: TextStyle(color: textColor,
              letterSpacing: -0.3,
              fontFamily: FontsAppTextFields.epilogueBold,
              fontSize: 14.sp),),
      ),
    );
  }
}
