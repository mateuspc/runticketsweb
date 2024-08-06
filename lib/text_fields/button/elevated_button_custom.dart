import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../text_style/fonts_text_fields.dart';
import '../text_style/input_text_colors.dart';
import '../utils/build_svg_icon.dart';

class ElevatedButtonCustom extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final bool enabled;
  final bool hasBorder;
  final Color borderColor;
  final String pathSvgSufixIcon;

  const ElevatedButtonCustom({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = InputTextColors.colorWhite,
    this.color = InputTextColors.colorPrimary,
    this.hasBorder = false,
    this.pathSvgSufixIcon = '',
    this.borderColor = InputTextColors.colorBlack,
    this.enabled = true,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: enabled ? () {
          HapticFeedback.mediumImpact();
          onPressed();
        } : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              width: hasBorder ? 1 : 0,
              color: hasBorder ? borderColor : InputTextColors.colorTransparent
            )
          ), // Adiciona o StadiumBorder
          elevation: 0,
          backgroundColor: enabled ?
          color :
          InputTextColors.colorGrey300,
        ),
        child: isLoading ? const CircularProgressIndicator(
          color: InputTextColors.colorWhite,
        ) :
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
              style: TextStyle(color: textColor,
                fontFamily: FontsAppTextFields.epilogueBold,
                letterSpacing: -0.3,
                fontSize: 14),),
            if(pathSvgSufixIcon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: buildSvgIconModuleTextFields(
                pathSvgSufixIcon,
                 size: 10
              ),
            )
          ],
        ),
      ),
    );
  }
}
