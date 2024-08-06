
import 'package:flutter/material.dart';

class SortDirectionDropdownInput extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const SortDirectionDropdownInput({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _sortDirections = {
      'Ascendente': 'asc',
      'Descendente': 'desc',
    };

    // Encontra o rótulo correspondente ao valor inicial
    String displayValue = _sortDirections.keys.firstWhere(
          (key) => _sortDirections[key] == initialValue,
      orElse: () => 'Ascendente',
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: DropdownButton<String>(
        value: displayValue,
        isDense: true,
        dropdownColor: Colors.white,
        items: _sortDirections.keys.map((String displayName) {
          return DropdownMenuItem<String>(
            value: displayName,
            child: Text(
              displayName,
              style: const TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
        onChanged: (newDisplayName) {
          final newSortDirection = _sortDirections[newDisplayName!]!;
          onChanged(newSortDirection);
        },
        underline: Container(),
      ),
    );
  }
}