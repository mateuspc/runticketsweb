
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildSvgIconModuleTextFields(String path, {double size = 20, Color color = Colors.white}) {
  return SvgPicture.asset(
    path,
    height: size,
    width: size,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}