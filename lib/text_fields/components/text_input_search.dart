
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../text_style/input_text_colors.dart';

class TextInputSearch extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isObscure;
  final String? label;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;
  final List<TextInputFormatter>? formatters;
  final Widget? iconText;
  final double? height;
  final bool enable;
  final SvgPicture? prefixIcon;
  final SvgPicture? suffixIcon;
  final bool keepBorderDefault;

  const TextInputSearch({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.isObscure = false,
    this.enable = true,
    this.keyboardType,
    this.onTap,
    this.keepBorderDefault = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.focusNode,
    this.onChanged,
    this.formatters,
    this.iconText,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          if (label != null) ...[
            Row(
              children: [
                if (iconText != null) ...[
                  iconText!,
                  const SizedBox(width: 10),
                ],
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(label!,)),
              ],
            ),
          ],
          const SizedBox(height: 3),
          SizedBox(
            height: 40,
            child: TextFormField(
              enabled: enable,
              style: const TextStyle(color: InputTextColors.colorBlack),
              validator: validator,
              controller: controller,
              obscureText: isObscure,
              keyboardType: keyboardType,
              focusNode: focusNode,
              onTap: onTap,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: InputTextColors.colorGrey,
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                prefixIcon: prefixIcon != null
                    ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: prefixIcon,
                )
                    : null,
                suffixIcon: suffixIcon != null
                    ? GestureDetector(
                      onTap: (){
                        controller?.clear();
                        onChanged!("");
                      },
                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: suffixIcon,
                                      ),
                    )
                    : null,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const  BorderSide(
                        width: 0)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                    BorderSide(color: Colors.grey, width: 0)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Colors.grey, width: 0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Colors.grey, width: 0)),
              ),
              inputFormatters: formatters,
            ),
          ),
        ],
      ),
    );
  }
}