
import 'package:flutter/material.dart';

class ItensPerPageDropdownInput extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  const ItensPerPageDropdownInput({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _ItensPerPageDropdownInputState createState() => _ItensPerPageDropdownInputState();
}

class _ItensPerPageDropdownInputState extends State<ItensPerPageDropdownInput> {
  late int itemsPerPage;

  // Valores disponíveis no dropdown
  final List<int> _availableValues = [10, 15, 20, 25];

  @override
  void initState() {
    super.initState();
    // Verifica se o initialValue está entre os valores disponíveis
    itemsPerPage = _availableValues.contains(widget.initialValue)
        ? widget.initialValue
        : _availableValues[0]; // Define o primeiro valor disponível como padrão se o initialValue for inválido
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: DropdownButton<int>(
        value: itemsPerPage,
        isDense: true,
        dropdownColor: Colors.white,
        items: _availableValues.map((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(
              '$value',
              style: const TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            itemsPerPage = newValue!;
            widget.onChanged(itemsPerPage);
          });
        },
        underline: Container(),
      ),
    );
  }
}