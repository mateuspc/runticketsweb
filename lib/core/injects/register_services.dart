
import 'package:runtickets_web/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/location_service.dart';
import 'inject.dart';

void registerServicesInjects(){

  inject.registerFactory<LocationService>(
          () => LocationService()
  );
  inject.registerFactory<SharedPreferenceService>(
          () => SharedPreferenceService(inject<SharedPreferences>())
  );
}