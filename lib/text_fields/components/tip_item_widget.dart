import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TipPasswordWidget extends StatelessWidget {
  final String text;
  final bool validate;

  const TipPasswordWidget({
    super.key,
    required this.text,
    this.validate = false,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 15,
              color: validate ? Colors.green : Colors.grey),
          const SizedBox( width: 5,),
          Expanded(
            child: AutoSizeText(text, style: TextStyle(
                color: validate ? Colors.green : Colors.grey,
                fontSize: 12
            ),
              maxLines: 1,),
          )
        ],
      ),
    );
  }
}