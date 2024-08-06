
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildSvgIcon(String path, {double size = 20, Color color = Colors.white}) {
  return SvgPicture.asset(
    path,
    height: size,
    width: size,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}