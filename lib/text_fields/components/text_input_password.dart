import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons/uicons.dart';
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../enums/error_position.dart';
import '../enums/input_text_state_enum.dart';
import '../enums/password_strength_enum.dart';
import '../header/error_style_textfield.dart';
import '../header/header_textfield.dart';
import '../models/item_step.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/custom_content_padding.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/input_text_colors.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';
import 'tip_item_widget.dart';

class TextInputPassword extends StatefulWidget {
  final TextEditingController passwordController;
  final String label;
  final String? hint;
  final bool enabled;
  final bool obscureText;
  final bool showEsqueciMinhaSenha;
  final Function? onTapRedefinirSenha;
  final ValueChanged onChangedText;
  final String errorText;
  final bool validator;
  final ValueChanged onObscureText;
  final TextInputValidatorCubit cubit;
  final bool confirmPassword;
  final bool forceNotShowForcaSenha;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final TypeErrorPosition typeErrorPosition;
  final AnimationController animationController;

  const TextInputPassword(
      {super.key,
      required this.passwordController,
      required this.label,
      this.hint = "∗ ∗ ∗ ∗",
      this.showEsqueciMinhaSenha = false,
      this.onTapRedefinirSenha,
      required this.obscureText,
      this.confirmPassword = false,
      required this.cubit,
      this.typeErrorPosition = TypeErrorPosition.BOTTOM_LEFT,
      this.inputFormatters = const [],
      this.enabled = true,
      required this.animationController,
      this.textInputType = TextInputType.text,
      this.forceNotShowForcaSenha = false,
      required this.onChangedText,
      required this.errorText,
      required this.validator,
      required this.onObscureText});

  @override
  State<TextInputPassword> createState() => _TextInputPasswordState();
}

class _TextInputPasswordState extends State<TextInputPassword> {
  List<PasswordTip> _currentTipsPassword = [];
  TypePasswordStrength _typePasswordStrength = TypePasswordStrength.none;
  TypeTextFieldState textError = TypeTextFieldState.valided;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0.0),
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextInputValidatorCubit, TextInputState>(
      bloc: widget.cubit,
      listener: (BuildContext context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (error, extra) {
            textError = error;
          },
          changedCreatePasswordTextFieldStrength:
              (List<PasswordTip> currentTipsPassword,
                  TypePasswordStrength typePasswordStrength) {
            setState(() {
              _currentTipsPassword = currentTipsPassword;
              _typePasswordStrength = typePasswordStrength;
            });
          },
          changeObscureText: (value) {
            widget.onObscureText(value);
          },
        );
      },
      builder: (context, state) {
        return Container(
          child: state.maybeWhen(orElse: () {
            return SlideTransition(
              position: _offsetAnimation,
              child: Column(
                children: [
                  labelTopAndErrorTextFieldStr(
                      label: widget.label,
                      typePasswordStrength: _typePasswordStrength,
                      errorTop: widget.typeErrorPosition == TypeErrorPosition.TOP_RIGHT,
                      forceNotShowForcaSenha: widget.forceNotShowForcaSenha,
                      errorText: state.maybeWhen(
                        orElse: () {
                          return '';
                        },
                        valided: () {
                          return '';
                        },
                        error: (textError, extra) {
                          return InputUtils.getTextMessageError(textError);
                        },
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    child: Focus(
                      onFocusChange: (hasFocus) {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadiusDefault),
                        child: TextFormField(
                          key: const Key('textFieldPassword'),
                          controller: widget.passwordController,
                          keyboardType: widget.textInputType,
                          enabled: widget.enabled,
                          obscureText: widget.obscureText,
                          autocorrect: false,
                          style: styleTextFieldTextTyped(),
                          obscuringCharacter: "∗",
                          autofocus: false,
                          inputFormatters: widget.inputFormatters,
                          decoration: InputDecoration(
                              hintText: widget.hint,
                              fillColor: backgroundColorTextField,
                              filled: true,
                              isDense: true,
                              suffixIcon: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    widget.cubit.changeStatusObscureText(
                                        widget.obscureText);
                                  },
                                  child: Container(
                                      color: Colors.transparent,
                                      child: Icon(
                                        widget.obscureText
                                            ? UIcons.regularRounded.eye
                                            : UIcons.regularRounded.eye_crossed,
                                        size: 20,
                                      )),
                                ),
                              ),
                              hintStyle:  TextStyle(
                                  color: Colors.grey,
                                  fontSize: InputTextFontSize.fontSizeHint),
                              labelStyle:  TextStyle(
                                  color: Colors.grey,
                                  fontSize: InputTextFontSize.fontSizeHint),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              isCollapsed: true,
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
                                : defaultOutlineBorder()),
                          onChanged: (value) {
                            if (widget.confirmPassword) {
                              widget.cubit.validatePasswordRequired(value);
                              return;
                            }
                            widget.cubit.validatePassword(value);
                          },
                        ),
                      ),
                    ),
                  ),
                  if (!widget.confirmPassword && _currentTipsPassword.isNotEmpty)
                    const SizedBox(
                      height: 5,
                    ),
                  if (!widget.confirmPassword)
                    ..._currentTipsPassword.map((element) {
                      return TipPasswordWidget(
                        text: element.text,
                        validate: element.validate,
                      );
                    }),
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
                  if (widget.showEsqueciMinhaSenha)
                    Align(
                      alignment: Alignment.centerRight,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            widget.onTapRedefinirSenha!();
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text('Esqueci minha senha')),
                        ),
                      ),
                    ),

                ],
              ),
            );
          }),
        );
      },
    );
  }
}
