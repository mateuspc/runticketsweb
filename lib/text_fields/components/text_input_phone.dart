import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../enums/error_position.dart';
import '../enums/input_text_state_enum.dart';
import '../header/error_style_textfield.dart';
import '../header/header_textfield.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/custom_content_padding.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/input_text_colors.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';

class TextInputPhone extends StatefulWidget {
  final TextEditingController textController;
  final String label;
  final String hint;
  final bool enabled;
  final TextInputValidatorCubit cubit;
  final Icon? prefixIcon;
  final Function(bool value) onValided;
  final bool showPrefixIcon;
  final bool autoFocus;
  final TypeErrorPosition typeErrorPosition;

  const TextInputPhone({
    super.key,
    required this.textController,
    required this.label,
    required this.onValided,
    required this.hint,
    this.typeErrorPosition = TypeErrorPosition.BOTTOM_LEFT,
    this.autoFocus = false,
    this.showPrefixIcon = true,
    this.prefixIcon,
    required this.cubit,
    this.enabled = true,
  });

  @override
  State<TextInputPhone> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputPhone> {

  final maskPhone = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  TypeTextFieldState textError = TypeTextFieldState.valided;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextInputValidatorCubit, TextInputState>(
      bloc: widget.cubit,
      listener: (BuildContext context, TextInputState state) {
        state.maybeWhen(
          orElse: () {  },
          error: (error, extra){
            textError = error;
          }
        );
      },
      builder: (context, state) {
        return Column(
          children: [
            labelTopAndErrorTextFieldStr(
                label: widget.label,
                errorTop: widget.typeErrorPosition == TypeErrorPosition.TOP_RIGHT,
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
                    key: const Key('textFieldLogin'),
                    controller: widget.textController,
                    keyboardType: TextInputType.number,
                    enabled: true,
                    autocorrect: false,
                    autofocus: widget.autoFocus,
                    style: styleTextFieldTextTyped(),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      maskPhone
                    ],
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      fillColor: backgroundColorTextField,
                      isDense: true,
                      suffixIcon: (state is LoadingTextInputState) ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                    ) : null,
                      filled: true,
                      errorText: null,
                      prefixIcon: widget.showPrefixIcon ? widget.prefixIcon ?? const Icon(FontAwesomeIcons.whatsapp,
                         color: InputTextColors.colorPrimary,) : null,
                      hintStyle:  TextStyle(
                        color: Colors.grey,
                        fontSize: InputTextFontSize.fontSizeHint,
                      ),
                      labelStyle:  TextStyle(
                        color: Colors.grey,
                        fontSize: InputTextFontSize.fontSizeHint,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: buildEdgeInsets(),
                      border: state is ErrorTextInputState
                            ? OutlineInputBorder(
                            borderSide: const BorderSide(
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
                      widget.cubit.validatePhone(value);
                    },
                  ),
                ),
              ),
            ),
            if (state is ErrorTextInputState &&
                widget.typeErrorPosition == TypeErrorPosition.BOTTOM_LEFT)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0, left: 10),
                  child: Text(
                    InputUtils.getTextMessageError(textError),
                    style: errorStyleTextField(),
                  ),
                ),
              ),
            const SizedBox(height: 15,)
          ],
        );
      },
    );
  }

}