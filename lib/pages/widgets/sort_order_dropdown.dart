import 'package:flutter/material.dart';

class SortOrderDropdownInput extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const SortOrderDropdownInput({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _SortOrderDropdownInputState createState() => _SortOrderDropdownInputState();
}

class _SortOrderDropdownInputState extends State<SortOrderDropdownInput> {
  late String sortOrder;

  final Map<String, String> _sortOptions = {
    'Data Evento': 'dataevento',
    'Distância': 'distancia',
    'Nome': 'nome',
  };

  @override
  void initState() {
    super.initState();
    sortOrder = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: DropdownButton<String>(
        value: _sortOptions.keys.firstWhere((key) => _sortOptions[key] == sortOrder, orElse: () => 'Data Evento'),
        isDense: true,
        dropdownColor: Colors.white,
        items: _sortOptions.keys.map((String displayName) {
          return DropdownMenuItem<String>(
            value: displayName,
            child: Text(
              displayName,
              style: const TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
        onChanged: (newDisplayName) {
          final newSortOrder = _sortOptions[newDisplayName!]!;
          setState(() {
            sortOrder = newSortOrder;
            widget.onChanged(sortOrder);
          });
        },
        underline: Container(),
      ),
    );
  }
}