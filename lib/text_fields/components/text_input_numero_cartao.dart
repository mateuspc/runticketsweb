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
import '../text_style/custom_content_padding.dart';

class TextInputNumeroCartao extends StatefulWidget {
  final TextEditingController textController;
  final String label;
  final String hint;
  final bool enabled;
  final TextInputValidatorCubit cubit;

  final Function(bool value) onValided;

  const TextInputNumeroCartao({
    super.key,
    required this.textController,
    required this.label,
    required this.onValided,
    required this.hint,
    required this.cubit,
    this.enabled = true,
  });

  @override
  State<TextInputNumeroCartao> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputNumeroCartao> {

  String bandeiraCartao = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextInputValidatorCubit, TextInputState>(
      bloc: widget.cubit,
      listener: (BuildContext context, TextInputState state) {
       state.maybeWhen(orElse: () {

       },
         changedCreditCardFlag: (value){
           bandeiraCartao = value;
         }
       );
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
            SizedBox(
              child: Focus(
                onFocusChange: (hasFocus) {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusDefault),
                  child: TextField(
                    controller: widget.textController,
                    keyboardType: TextInputType.number,
                    enabled: true,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: true,
                    autofocus: false,
                    style: styleTextFieldTextTyped(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CartaoBancarioInputFormatter()
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
                      prefixIcon: bandeiraCartao.isEmpty ? null : Container(
                          width: 35,
                          padding: const EdgeInsets.only(right: 10, left: 5),
                          child: Image.asset(bandeiraCartao,)
                      ),
                      labelStyle:  TextStyle(
                        color: Colors.grey,
                        fontSize: InputTextFontSize.fontSizeHint,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: buildEdgeInsets(),
                      border: defaultOutlineBorder()
,
                    ),
                    onChanged: (value) {
                      widget.cubit.validateNumeroCartao(value);
                      widget.cubit.checkBandeiraCartao(value);
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
  String maskCreditCardNumber(String cardNumber) {
    // Verifica se o número do cartão tem pelo menos 4 dígitos
    if (cardNumber.length < 4) {
      return cardNumber; // Retorna o número original se for menor que 4 dígitos
    }

    // Obtém os últimos 4 dígitos do número do cartão
    String lastFourDigits = cardNumber.substring(cardNumber.length - 4);

    // Substitui os dígitos anteriores por asteriscos
    String maskedNumber = '*' * (cardNumber.length - 4) + lastFourDigits;

    return maskedNumber;
  }
  @override
  void dispose() {
    super.dispose();
  }
}
