
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:runtickets_web/core/views/app_colors.dart';

class CategoryOptionsCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String description;

  const CategoryOptionsCard({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? AppColors.colorPrimary : Colors.grey[100] as Color,
            width: 2.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected ? AppColors.colorPrimary : AppColors.midleGray,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // HtmlWidget(description)
                ],
              ),
            ),
            Radio<String>(
              value: label,
              groupValue: isSelected ? label : null,
              onChanged: (value) {
                onTap();
              },
              activeColor: AppColors.colorPrimary,
            ),
          ],
        ),
      ),
    );
  }
}