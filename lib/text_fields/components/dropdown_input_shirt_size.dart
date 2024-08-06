import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubit/text_input_cubit.dart';
import '../cubit/text_input_state.dart';
import '../enums/type_gender.dart';
import '../header/header_textfield.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/input_text_colors.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';
import '../utils/input_utils.dart';

class TextInputDropdownButtonShirtSize extends StatefulWidget {
  final String label;
  final ValueChanged<TypeShirtSize?> onChanged;
  final TextInputValidatorCubit cubit;
  final TypeShirtSize initialValue;

  const TextInputDropdownButtonShirtSize({
    super.key,
    this.label = 'Tamanho da camisa',
    required this.onChanged,
    required this.cubit,
    required this.initialValue
  });

  @override
  _TextInputDropdownButtonShirtSizeState createState() => _TextInputDropdownButtonShirtSizeState();
}

class _TextInputDropdownButtonShirtSizeState extends State<TextInputDropdownButtonShirtSize> {
  TypeShirtSize? _selectedShirtSize;

  @override
  void initState() {
    _selectedShirtSize = widget.initialValue;
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
              child: DropdownButtonFormField<TypeShirtSize>(
                value: _selectedShirtSize,
                borderRadius: BorderRadius.circular(borderRadiusDefault),
                style: styleTextFieldTextTyped(),
                dropdownColor: Colors.white, // Definindo a cor de fundo do menu suspenso
                decoration: InputDecoration(
                  hintText: 'Selecione uma opção',
                  fillColor: backgroundColorTextField
,
                  filled: true,
                  prefixIcon: const Icon(FontAwesomeIcons.shirt, color: InputTextColors.colorGrey,),
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: InputTextFontSize.fontSizeHint,
                      fontWeight: FontWeight.bold,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: InputTextFontSize.fontSizeHint,
                  ),

                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  border: defaultOutlineBorder()
,
                ),
                items: const [
                  DropdownMenuItem(
                    value: TypeShirtSize.p,
                    child: Text('P'),
                  ),
                  DropdownMenuItem(
                    value: TypeShirtSize.m,
                    child: Text('M'),
                  ),
                  DropdownMenuItem(
                    value: TypeShirtSize.g,
                    child: Text('G'),
                  ),
                  DropdownMenuItem(
                    value: TypeShirtSize.gg,
                    child: Text('GG'),
                  ),
                  DropdownMenuItem(
                    value: TypeShirtSize.xg,
                    child: Text('XG'),
                  ),
                ],
                onChanged: (TypeShirtSize? value) {
                  widget.cubit.validateShirtSize(value?.name);
                  _selectedShirtSize = value;
                  widget.onChanged(_selectedShirtSize);
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


