import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../header/header_textfield.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/custom_content_padding.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/input_text_colors.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';

class TextInputComplemento extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool enabled;
  final TextInputValidatorCubit cubit;
  final Function? onTapEdit;
  final Function(bool value) onValided;

  const TextInputComplemento({
    super.key,
    required this.controller,
    required this.label,
    required this.onValided,
    required this.hint,
    this.onTapEdit,
    required this.cubit,
    this.enabled = true,
  });

  @override
  State<TextInputComplemento> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputComplemento> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextInputValidatorCubit, TextInputState>(
      bloc: widget.cubit,
      listener: (BuildContext context, TextInputState state) {

      },
      builder: (context, state) {
        return Column(
          children: [
            labelTopAndErrorTextFieldStr(
                label: widget.label,
                errorText: state.maybeWhen(orElse:() {
                  return '';
                },
                    valided: (){
                      return '';
                    },
                    error: (textError, extra){
                      return InputUtils.getTextMessageError(textError);
                    }
                )),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              child: Focus(
                onFocusChange: (hasFocus) {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusDefault),
                  child: TextField(
                    key: const Key('textFieldComplemento'),
                    controller: widget.controller,
                    keyboardType: TextInputType.text,
                    enabled: widget.enabled,
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,
                    style: styleTextFieldTextTyped(enabled: widget.enabled),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
                    ],
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      fillColor: backgroundColorTextField,
                      filled: true,
                      errorText: null,
                      hintStyle:  TextStyle(
                        color: Colors.grey,
                        fontSize: InputTextFontSize.fontSizeHint,
                      ),
                      labelStyle:  TextStyle(
                        color: Colors.grey,
                        fontSize: InputTextFontSize.fontSizeHint,
                      ),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: buildEdgeInsets(),
                      border: state is ErrorTextInputState
                          ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: InputTextColors.colorRed,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8))
                          : defaultOutlineBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: InputTextColors.colorRed,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: InputTextColors.colorRed,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      enabledBorder: defaultOutlineBorder(),
                      focusedBorder: state is ErrorTextInputState
                          ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: InputTextColors.colorRed,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8))
                          : defaultOutlineBorder(),
                    ),
                    onChanged: (value) {
                      widget.cubit.validateComplemento(value);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,)
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
