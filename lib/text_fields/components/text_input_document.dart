import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../enums/error_position.dart';
import '../enums/input_text_state_enum.dart';
import '../header/error_style_textfield.dart';
import '../header/header_textfield.dart';
import '../text_style/custom_content_padding.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/input_text_colors.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';

enum TypeDocument {
  cpf,
  cnpj,
  rne,
  passaporte,
}

class TextInputDocument extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool enabled;
  final TypeDocument currentDocument;
  final TextInputValidatorCubit cubit;
  final bool autoFocus;
  final TypeErrorPosition typeErrorPosition;
  final AnimationController animationController;
  final bool showCleanTextField;

  const TextInputDocument({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.enabled = true,
    required this.animationController,
    this.showCleanTextField = false,
    this.autoFocus = false,
    this.typeErrorPosition = TypeErrorPosition.BOTTOM_LEFT,
    required this.cubit,
    required this.currentDocument,
  });

  @override
  State<TextInputDocument> createState() => _TextInputDocumentState();
}

class _TextInputDocumentState extends State<TextInputDocument> {

   String _hintTypeDocumentCurrent = "Digite o CPF";
   TextInputType _textInputTypeCurrent = TextInputType.number;
   MaskTextInputFormatter _maskTextInputFormatter =
   MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
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
      listener: (context, state){
        state.maybeWhen(
            orElse: () {  },
            error: (error, extra){
              textError = error;
            },
            changedDocumentType: (String hint,
                MaskTextInputFormatter maskTextInputFormatter,
                TextInputType textInputType){
              setState(() {
                _hintTypeDocumentCurrent = hint;
                _maskTextInputFormatter = maskTextInputFormatter;
                _textInputTypeCurrent = textInputType;
              });
            }
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
            orElse: () {
              return SlideTransition(
                position: _offsetAnimation,
                child: Column(
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
                        onFocusChange: (hasFocus) {
                
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadiusDefault),
                          child: TextFormField(
                            key: const Key('textFieldDocument'),
                            controller: widget.controller,
                            keyboardType: _textInputTypeCurrent,
                            enabled: true,
                            autofocus: widget.autoFocus,
                            inputFormatters: [
                              _maskTextInputFormatter
                            ],
                            style: styleTextFieldTextTyped(),
                            decoration: InputDecoration(
                              hintText: _hintTypeDocumentCurrent,
                              fillColor: InputTextColors.colorWhite,
                              filled: true,
                              isDense: true,
                              hintStyle:  TextStyle(
                                color: InputTextColors.colorGreyHint,
                                fontSize: InputTextFontSize.fontSizeHint,
                              ),
                              suffixIcon: widget.showCleanTextField ? IconButton(
                                onPressed: () {
                                  widget.controller.clear();
                                },
                                icon: Icon(Icons.clear,
                                  color: state is  ErrorTextInputState ? InputTextColors.colorRed
                                      : InputTextColors.colorGrey,),
                              ) : null,
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: InputTextFontSize.fontSizeHint,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              isCollapsed: true,
                              contentPadding: buildEdgeInsets(),
                              disabledBorder: defaultOutlineBorder(),
                              border: state is  ErrorTextInputState ? OutlineInputBorder(
                             borderSide: const BorderSide(
                            color: InputTextColors.colorRed,
                              width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8)
                            ) : defaultOutlineBorder(),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: InputTextColors.colorRed,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: InputTextColors.colorRed,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              enabledBorder: defaultOutlineBorder(),
                              focusedBorder: state is  ErrorTextInputState ? OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: InputTextColors.colorRed,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ) : defaultOutlineBorder(),

                            ),

                            onChanged: (value) {
                              widget.cubit.validateDocument(
                                  value,
                                  widget.currentDocument,
                                  hasRequired: false
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    if(state is ErrorTextInputState &&
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
                ),
              );
            },

        );
      }
    );
  }




}
