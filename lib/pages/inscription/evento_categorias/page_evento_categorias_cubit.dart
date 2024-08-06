import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runtickets_web/core/constants/share_preferece_constants.dart';
import 'package:runtickets_web/data/events_repository.dart';
import 'package:runtickets_web/models/api_response.dart';
import 'package:runtickets_web/models/responses/success_get_event_categorias_response.dart';
import 'package:runtickets_web/services/shared_preference_service.dart';
import 'page_evento_categorias_state.dart';

class PageEventoCategoriasCubit extends Cubit<PageEventoCategoriasState> {

  EventsRepository _eventoRepository;
  final SharedPreferenceService _sharedPreferenceService;

  PageEventoCategoriasCubit(this._eventoRepository, this._sharedPreferenceService) : super(const PageEventoCategoriasState.initial());

  void getEventCategoria() async {
    try{
      emit(const PageEventoCategoriasState.loading());

      ApiResponse apiResponse = await _eventoRepository.getEventoCategoria();
      if(apiResponse.ok){
        GetEventCategoriaResponse res = apiResponse.result as GetEventCategoriaResponse;

        bool newInscription = await hasNewInscription();
        emit(PageEventoCategoriasState.success(res, newInscription));
        return;
      }
      emit(const PageEventoCategoriasState.error("Error"));

    } on SocketException catch (e) {
      emit(PageEventoCategoriasState.offline(onTryAgain: () {
        getEventCategoria();
      }));
    } catch(e, stacktrace){
      emit(PageEventoCategoriasState.error(stacktrace.toString()));

    }
  }

  Future<bool> hasNewInscription() async {
    Map<String, dynamic>? dataSubscription =
        await _sharedPreferenceService.getCurrentDataSubscription();
    String? inscricaoId = dataSubscription?[DataSubscription.inscricaoId].toString();
    return inscricaoId ==  'null';

  }
  Future<void> addCategory(String categoryId) async {
   await _sharedPreferenceService.addCategory(categoryId.toString());
  }

}