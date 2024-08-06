
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/views/app_fonts.dart';


class AtAppBar extends AppBar {
  AtAppBar({
    super.key,
    required String title,
    Widget? leading,
    Color? backgroundColor,
    Color? titleColor,
    List<Widget> actions = const [],
  }) : super(
    title: Text(
      title,
      style: TextStyle(
          fontFamily: FontsApp.epilogueMedium,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: titleColor ?? Colors.black
      ),
    ),
    backgroundColor: backgroundColor,
    elevation: 0,
    centerTitle: true,
    leading: leading,
    actions: [...actions],
  );
}

class AtSliverAppBar extends SliverAppBar {
  AtSliverAppBar({
    super.key,
    required String title,
    super.leading,
    List<Widget> actions = const [],
  }) : super(
    title: Text(
      title,
      style: TextStyle(
          fontFamily: FontsApp.epilogueMedium,
          fontWeight: FontWeight.w500,
          fontSize: 14
      ),
    ),
    floating: true,
    snap: false,
    elevation: 0,
    centerTitle: true,
    actions: [...actions],
  );
}