import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../enums/type_gender.dart';
import '../header/header_textfield.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';

class TextInputDropdownButtonGender extends StatefulWidget {
  final String label;
  final ValueChanged<TypeGender?> onChanged;
  final TextInputValidatorCubit cubit;
  final TypeGender? initialValue;
  const TextInputDropdownButtonGender({
    super.key,
    this.label = 'Gênero',
    this.initialValue,
    required this.onChanged,
    required this.cubit
  });

  @override
  _TextInputDropdownButtonGenderState createState() => _TextInputDropdownButtonGenderState();
}

class _TextInputDropdownButtonGenderState extends State<TextInputDropdownButtonGender> {
  TypeGender? _selectedGender;

  @override
  void initState() {
    _selectedGender = widget.initialValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextInputValidatorCubit, TextInputState>(
      bloc: widget.cubit,
      listener: (BuildContext context, TextInputState state) {},
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
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadiusDefault),
              child: DropdownButtonFormField<TypeGender>(
                value: _selectedGender,
                borderRadius: BorderRadius.circular(borderRadiusDefault),
                style: styleTextFieldTextTyped(),
                dropdownColor: Colors.white, // Definindo a cor de fundo do menu suspenso
                decoration: InputDecoration(
                  hintText: 'Selecione uma opção',
                  fillColor: backgroundColorTextField
,
                  filled: true,
                  hintStyle:  TextStyle(
                      color: Colors.grey,
                      fontSize: InputTextFontSize.fontSizeHint,
                      fontWeight: FontWeight.bold
                  ),
                  labelStyle:  TextStyle(
                    color: Colors.grey,
                    fontSize: InputTextFontSize.fontSizeHint,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  border: defaultOutlineBorder()
,
                ),
                items: const [
                  DropdownMenuItem(
                    value: TypeGender.F,
                    child: Text('Feminino'),
                  ),
                  DropdownMenuItem(
                    value: TypeGender.M,
                    child: Text('Masculino'),
                  ),
                ],
                onChanged: (TypeGender? value) {
                    widget.cubit.validateGender(value?.name);
                    _selectedGender = value;
                    widget.onChanged(_selectedGender);
                },
              ),
            ),
            const SizedBox(height: 15,)
          ],
        );
      },
    );

  }
}


