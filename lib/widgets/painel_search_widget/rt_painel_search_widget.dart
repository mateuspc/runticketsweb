import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RtPainelSearchWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Function(String query) applyFilter;
  final TextEditingController textSearchFieldController;

  const RtPainelSearchWidget({
    super.key,
    required this.onChanged,
    required this.textSearchFieldController,
    required this.applyFilter,
  });

  @override
  State<RtPainelSearchWidget> createState() => _RtPainelSearchWidgetState();
}

class _RtPainelSearchWidgetState extends State<RtPainelSearchWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.3,
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              border: Border.all(
                color: isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                  child: AutoSizeText(
                    'Pesquisar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[700] : Colors.white,
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.grey[600]!
                            : Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: widget.textSearchFieldController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Pesquisar por...',
                        hintStyle: TextStyle(
                          color: isDarkMode ? Colors.grey[400] : Colors.grey,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            widget.applyFilter(widget.textSearchFieldController.text);
                          },
                          child: Icon(
                            Icons.search,
                            color: isDarkMode ? Colors.grey[400] : Colors.grey,
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 30,
                          minHeight: 30,
                        ),
                      ),
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: widget.onChanged,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
