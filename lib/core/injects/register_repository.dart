

import 'package:http/http.dart' as http;
import 'package:runtickets_web/data/events_repository.dart';
import 'package:runtickets_web/services/shared_preference_service.dart';

import '../../services/location_service.dart';
import 'inject.dart';

void registerRepositoryInjects(){

  inject.registerFactory<EventsRepository>(() => EventsRepository(
      inject<http.Client>(), inject<LocationService>(), inject<SharedPreferenceService>()));

}