import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'routes/app_routes.dart';
import 'views/app_theme.dart';

class RunTickets extends StatelessWidget {
  const RunTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Run Tickets',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      routerConfig: AppRoutes.router,
    );
  }
}
