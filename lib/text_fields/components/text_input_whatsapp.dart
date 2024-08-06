
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../enums/input_text_state_enum.dart';
import '../header/header_textfield.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';

class TextInputWhatsapp extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool enabled;
  final GlobalKey<FormState> formKey;

  const TextInputWhatsapp(
      {super.key,
        required this.controller,
        required this.label,
        required this.hint,
        required this.formKey,
        this.enabled = true});

  @override
  State<TextInputWhatsapp> createState() => _TextInputWhatsappState();
}

class _TextInputWhatsappState extends State<TextInputWhatsapp> {
  TypeTextFieldState statusTextField = TypeTextFieldState.valided;
  final MaskTextInputFormatter _maskPhoneBR = MaskTextInputFormatter(mask: "(##)#####-####");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        labelTopAndErrorTextField(label: widget.label, statusTextField: statusTextField),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          child: Focus(
            onFocusChange: (hasFocus){
              if (widget.controller.text.isEmpty) {
                setState(() {
                  statusTextField = TypeTextFieldState.valided;
                });
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadiusDefault),
              child: TextFormField(
                key: const Key('textFieldWhatsappPhone'),
                controller: widget.controller,
                keyboardType: TextInputType.number,
                enabled: true,
                style: styleTextFieldTextTyped(),
                inputFormatters: [
                  _maskPhoneBR
                ],
                decoration: InputDecoration(
                    hintText: widget.hint,
                    fillColor: backgroundColorTextField,
                    filled: true,
                    hintStyle:  TextStyle(color: Colors.grey,
                        fontSize: InputTextFontSize.fontSizeHint),
                    labelStyle:  TextStyle(color: Colors.grey,
                        fontSize: InputTextFontSize.fontSizeHint),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
                    border: defaultOutlineBorder()),
                validator: (value) {
                  if (value!.isEmpty && !FocusScope.of(context).hasFocus) {
                    setState(() {
                      statusTextField = TypeTextFieldState.errorFieldRequired;
                    });
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.formKey.currentState?.validate();
                },

              ),
            ),
          ),
        ),
        const SizedBox(height: 15,)
      ],
    );
  }
}
