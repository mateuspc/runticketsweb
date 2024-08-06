import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../header/header_textfield.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';

class TextInputCityPreference extends StatefulWidget {
  final TextEditingController textController;
  final String label;
  final String hint;
  final bool enabled;
  final TextInputValidatorCubit cubit;
  final VoidCallback onTap;
  final Function(bool value) onValided;

  const TextInputCityPreference({
    super.key,
    required this.textController,
    required this.label,
    required this.onValided,
    required this.hint,
    required this.onTap,
    required this.cubit,
    this.enabled = true,
  });

  @override
  State<TextInputCityPreference> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputCityPreference> {

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadiusDefault),
                child: TextField(
                  key: const Key('textFieldCityPreference'),
                  controller: widget.textController,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  autocorrect: false,
                  autofocus: false,
                  showCursor: false,
                  style: styleTextFieldTextTyped(),
                  onTap: (){
                    widget.onTap();
                  },
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
                    widget.cubit.validateCityPreference(value);
                  },
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
