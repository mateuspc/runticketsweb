import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../header/header_textfield.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';

class TextInputValidadeCartao extends StatefulWidget {
  final TextEditingController textController;
  final String label;
  final String hint;
  final bool enabled;
  final TextInputValidatorCubit cubit;

  final Function(bool value) onValided;

  const TextInputValidadeCartao({
    super.key,
    required this.textController,
    required this.label,
    required this.onValided,
    required this.hint,
    required this.cubit,
    this.enabled = true,
  });

  @override
  State<TextInputValidadeCartao> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputValidadeCartao> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextInputValidatorCubit, TextInputState>(
      bloc: widget.cubit,
      listener: (BuildContext context, TextInputState state) {

      },
      builder: (context, state) {
        return SizedBox(
          height: 100,
          width: 100,
          child: Column(
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
              SizedBox(
                child: Focus(
                  onFocusChange: (hasFocus) {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusDefault),
                    child: TextField(
                      controller: widget.textController,
                      keyboardType: TextInputType.number,
                      enabled: true,
                      textCapitalization: TextCapitalization.words,
                      autocorrect: true,
                      autofocus: false,
                      style: styleTextFieldTextTyped(),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        ValidadeCartaoInputFormatter()
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
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 5,
                        ),
                        border: defaultOutlineBorder()
,
                      ),
                      onChanged: (value) {
                        widget.cubit.validateDataCartao(value);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,)
            ],
          ),
        );
      },
    );
  }
}
