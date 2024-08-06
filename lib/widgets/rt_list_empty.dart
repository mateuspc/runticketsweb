
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:runtickets_web/core/views/app_colors.dart';

class RtListEmpty extends StatelessWidget {

  final String? text;

  const RtListEmpty({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/fi-rr-search.svg",
          height: 80,
          colorFilter: const ColorFilter.mode(AppColors.colorGrey, BlendMode.srcIn),
        ),
        const SizedBox(height: 20),
        Text(text ?? 'Nenhum resultado',),
      ],
    );
  }
}
