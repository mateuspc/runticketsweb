import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:runtickets_web/pages/auth/login/page_login.dart';
import 'package:runtickets_web/pages/detalhes_corrida/page_detalhes_corrida.dart';
import 'package:runtickets_web/pages/page_dashboard.dart';
import 'package:runtickets_web/pages/settings/page_settings.dart';

class AppRoutes {

  static const pageLogin = "/";
  static const pageDashboard = "/pageDashboard";
  static const pageDetailsEvent = "/details";
  static const pageSettings = "/settings";


  static final router = GoRouter(
      errorBuilder: ((context, state) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/page_not_found.png'
              ),
            ),
            Text('Pagina não encontrada.')
          ],
        ),
      )),
      routes: [
        GoRoute(
            name: 'settings',
            path: pageSettings,
            builder: (context, route) => PageSettings()
        ),
        GoRoute(
            name: 'login',
            path: pageLogin,
            builder: (context, route) => PageLogin()
        ),
        GoRoute(
          name: 'dashboard/:id',
          path: pageDashboard,
          builder: (context, route) => PageDashboard()
        ),
        GoRoute(
            name: 'details',
            path: '$pageDetailsEvent/:id',
            builder: (context, state) {

              return RaceDetailScreen();
            }
        ),
      ]
  );
}