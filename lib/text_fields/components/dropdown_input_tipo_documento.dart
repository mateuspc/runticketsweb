import 'package:flutter/material.dart';
import '../enums/input_text_state_enum.dart';
import '../text_style/background_textinput_color.dart';
import '../text_style/default_border_textfield.dart';
import '../text_style/input_text_colors.dart';
import 'text_input_document.dart';
import '../text_style/style_text_field.dart';
import '../utils/input_fontsize.dart';


class TextInputDropdownButtonTipoDocument extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool enabled;
  final ValueChanged onChanged;
  final TypeDocument? initialValue;

  const TextInputDropdownButtonTipoDocument(
      {super.key,
        required this.controller,
        required this.label,
        required this.hint,
        this.initialValue,
        required this.onChanged,
        this.enabled = true});

  @override
  State<TextInputDropdownButtonTipoDocument> createState() => _TextInputDropdownButtonTipoDocumentState();
}

class _TextInputDropdownButtonTipoDocumentState extends State<TextInputDropdownButtonTipoDocument> {
  TypeTextFieldState statusTextField = TypeTextFieldState.valided;

  TypeDocument? typeDocument;

  @override
  void initState() {
    typeDocument = widget.initialValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          child: Focus(
            onFocusChange: (hasFocus){
              if (widget.controller.text.isEmpty) {
                setState(() {
                  statusTextField = TypeTextFieldState.valided;
                });
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadiusDefault),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(borderRadiusDefault),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  fillColor: backgroundColorTextField
,
                  filled: true,
                  hintStyle:  TextStyle(
                    color: Colors.grey,
                    fontSize: InputTextFontSize.fontSizeHint,
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
                validator: (value) {
                  if (value!.isEmpty && !FocusScope.of(context).hasFocus) {
                    setState(() {
                      statusTextField = TypeTextFieldState.errorFieldRequired;
                    });
                  }
                  return null;
                },
                alignment: AlignmentDirectional.centerStart,
                dropdownColor: InputTextColors.colorWhite, // Altere para a cor desejada
                onChanged: (value) {
                  widget.controller.text = "";
                  widget.onChanged(getTypeDocumentFromString(value!));
                },
                style: styleTextFieldTextTyped(),
                value: getStrPreviewFromDocumentType(widget.initialValue ?? TypeDocument.cpf), // Set 'CPF' as the default value
                items: ['CPF', 'CNPJ', 'Estrangeiro(RNE)', 'Estrangeiro(Passaporte)']
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style:  TextStyle(
                    fontSize: InputTextFontSize.fontSizeLabel
                  ),),
                ))
                    .toList(),

                // Configurando a posição da janela
                // Neste exemplo, estou movendo a janela para baixo adicionando 80 pixels à posição vertical
                menuMaxHeight: 200, // Defina a altura máxima do menu conforme necessário
                elevation: 8, // Ajuste a elevação conforme necessário
                selectedItemBuilder: (BuildContext context) {
                  return ['CPF', 'CNPJ', 'Estrangeiro(RNE)', 'Estrangeiro(Passaporte)']
                      .map<Widget>((String item) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(item),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 15,)
      ],
    );
  }
  TypeDocument getTypeDocumentFromString(String documentType) {
    switch (documentType) {
      case 'CPF':
        return TypeDocument.cpf;
      case 'CNPJ':
        return TypeDocument.cnpj;
      case 'Estrangeiro(RNE)':
        return TypeDocument.rne;
      case 'Estrangeiro(Passaporte)':
        return TypeDocument.passaporte;
      default:
        throw ArgumentError('Tipo de documento desconhecido: $documentType');
    }
  }

  String getStrPreviewFromDocumentType(TypeDocument documentType) {
    switch (documentType) {
      case TypeDocument.cpf:
        return 'CPF';
      case TypeDocument.cnpj:
        return 'CNPJ';
      case TypeDocument.rne:
        return 'Estrangeiro(RNE)';
      case TypeDocument.passaporte:
        return 'Estrangeiro(Passaporte)';
      default:
        throw ArgumentError('Tipo de documento desconhecido: $documentType');
    }
  }


  }
