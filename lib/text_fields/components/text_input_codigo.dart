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

class TextInputCodigo extends StatefulWidget {
  final TextEditingController codigoController;
  final String label;
  final String hint;
  final bool enabled;
  final TextInputValidatorCubit cubit;

  final Function(bool value) onValided;

  const TextInputCodigo({
    Key? key,
    required this.codigoController,
    required this.label,
    required this.onValided,
    required this.hint,
    required this.cubit,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<TextInputCodigo> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputCodigo> {

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
                    key: const Key('textFieldLogin'),
                    controller: widget.codigoController,
                    keyboardType: TextInputType.number,
                    enabled: true,
                    autocorrect: false,
                    autofocus: false,
                    style: styleTextFieldTextTyped(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
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
                        horizontal: 10,
                      ),
                      border: defaultOutlineBorder()
,
                    ),
                    onChanged: (value) {
                      widget.cubit.validateCodigoLocalmente(value);
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
