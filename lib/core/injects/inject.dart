import 'package:get_it/get_it.dart';
import 'package:http_interceptor_plus/http_interceptor_plus.dart';
import 'package:runtickets_web/core/injects/register_cubit.dart';
import 'package:runtickets_web/core/injects/register_repository.dart';
import 'package:runtickets_web/core/injects/register_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


Future<void> setupInjection() async {
  await inject.reset();

  final sharedPreferences = await SharedPreferences.getInstance();

  final http.Client client = LoggingMiddleware(http.Client());

  inject.registerFactory<http.Client>(() => client);

  inject.registerSingleton<SharedPreferences>(sharedPreferences);

  registerServicesInjects();
  registerRepositoryInjects();
  registerCubitInjects();

  return inject.allReady();
}

GetIt inject = GetIt.instance;