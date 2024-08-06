import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // Import the mask formatter package
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../enums/input_text_state_enum.dart';
import '../enums/type_pix.dart';
import '../header/error_style_textfield.dart';
import '../text_style/fonts_text_fields.dart';
import '../text_style/input_text_colors.dart';
import '../utils/input_utils.dart';

class TextInputPix extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool enabled;
  final TextInputValidatorCubit cubit;
  final Function(bool value) onValided;
  final bool autoFocus;
  final AnimationController animationController;
  final Function(TypePix value) onChangeTypePix;

  const TextInputPix({
    super.key,
    required this.controller,
    required this.label,
    required this.onValided,
    required this.hint,
    required this.onChangeTypePix,
    required this.animationController,
    this.autoFocus = false,
    required this.cubit,
    this.enabled = true,
  });

  @override
  State<TextInputPix> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputPix> {
  TypeTextFieldState textError = TypeTextFieldState.valided;
  late Animation<Offset> _offsetAnimation;
  bool isEmail = false;

  final cpfMaskFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final cnpjMaskFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##');

  @override
  void initState() {
    super.initState();
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0.0),
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(widget.animationController);
  }

  void _applyMask(String value, MaskTextInputFormatter maskFormatter) {
    final unmaskedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    final maskedValue = maskFormatter.formatEditUpdate(
      TextEditingValue(text: unmaskedValue),
      TextEditingValue(text: unmaskedValue),
    ).text;
    widget.controller.value = TextEditingValue(
      text: maskedValue,
      selection: TextSelection.collapsed(offset: maskedValue.length),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextInputValidatorCubit, TextInputState>(
      bloc: widget.cubit,
      listener: (BuildContext context, TextInputState state) {
        state.maybeWhen(
          orElse: () {
            widget.onChangeTypePix(TypePix.undefined);
          },
          error: (error, extra) {
            widget.onChangeTypePix(TypePix.undefined);
            textError = error;
          },
          validedCpfPix: () {
            _applyMask(widget.controller.text, cpfMaskFormatter);
            widget.onChangeTypePix(TypePix.cpf);
          },
          validedCnpjPix: () {
            _applyMask(widget.controller.text, cnpjMaskFormatter);
            widget.onChangeTypePix(TypePix.cnpj);

          },
          validedEmailPix: () {
            widget.onChangeTypePix(TypePix.email);
          },
          validedUndefinedPix: (){
            widget.onChangeTypePix(TypePix.undefined);
          }
        );
      },
      builder: (context, state) {
        return SlideTransition(
          position: _offsetAnimation,
          child: Column(
            children: [
              SizedBox(
                child: TextField(
                  controller: widget.controller,
                  style: TextStyle(
                    color: InputTextColors.colorPrimary,
                    fontSize: 20.sp,
                    fontFamily: FontsAppTextFields.epilogueSemiBold,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autofocus: widget.autoFocus,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    enabledBorder: _defaultUnderlineBorder(),
                    border: _defaultUnderlineBorder(),
                    focusedBorder: _defaultUnderlineBorder(),
                  ),
                  onChanged: (value) {
                    widget.cubit.validateKeyPIX(value);
                  },
                ),
              ),
              if (state is ErrorTextInputState)
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
            ],
          ),
        );
      },
    );
  }

  UnderlineInputBorder _defaultUnderlineBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: InputTextColors.colorRedViolet,
        width: 2,
      ),
    );
  }
}
