import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:runtickets_web/core/injects/inject.dart';
import 'package:runtickets_web/core/rt_app.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  setupInjection();
  Bloc.observer = SimpleBlocObserver();

  runApp(const RunTickets());
}


