
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runtickets_web/core/views/app_fonts.dart';

import 'app_colors.dart';

class ThemeConfig {
  ThemeConfig._();

  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorPrimary),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.colorWhite,
    fontFamily: FontsApp.epilogueRegular,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Defina a cor desejada da barra de status
        statusBarIconBrightness: Brightness.dark, // Defina a cor desejada dos ícones da barra de status
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return const TextStyle(color: Colors.white);
          }
          return const TextStyle(color: Colors.white);
        }),
        iconTheme: WidgetStateProperty.resolveWith((state){
          if(state.contains(WidgetState.pressed)){
            return const IconThemeData(
                color: Colors.white
            );
          }
          return const IconThemeData(
              color: Colors.grey
          );
        })
    ),

  );
}
