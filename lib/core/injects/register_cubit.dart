import 'package:runtickets_web/data/events_repository.dart';
import 'package:runtickets_web/pages/detalhes_corrida/page_detalhes_corrida_cubit.dart';
import 'package:runtickets_web/pages/inscription/evento_categorias/page_evento_categorias_cubit.dart';
import 'package:runtickets_web/pages/page_dashboard_cubit.dart';
import 'package:runtickets_web/services/location_service.dart';
import 'package:runtickets_web/services/shared_preference_service.dart';

import '../../text_fields/cubit/text_input_cubit.dart';
import 'inject.dart';

void registerCubitInjects() {

  inject.registerFactory<TextInputValidatorCubit>(() =>
      TextInputValidatorCubit());
  inject.registerFactory<PageEventoCategoriasCubit>(() =>
      PageEventoCategoriasCubit(
          inject<EventsRepository>(), inject<SharedPreferenceService>()));
  inject.registerFactory<PageCorridaDetalhesCubit>(() =>
      PageCorridaDetalhesCubit(
          inject<EventsRepository>(), inject<LocationService>()));
  inject.registerFactory<PageDashboardCubit>(
      () => PageDashboardCubit(inject<EventsRepository>()));
}
