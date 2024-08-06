
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../data/events_repository.dart';
import '../models/api_response.dart';
import '../models/responses/success_get_events_response.dart';
import 'page_dashboard_state.dart';

class PageDashboardCubit extends Cubit<PageDashboardState> {

  final EventsRepository _eventsRepository;
  final TextEditingController textSearchFieldController = TextEditingController();

  PageDashboardCubit(this._eventsRepository) : super(const PageDashboardState.initial());

  void getEvents(Map<String, dynamic> mapQueryParams, {
    bool showLoadingFullScreen = true,
    bool showLoadingListOnly = false
  }) async {


    try {
      if(showLoadingFullScreen) emit(const PageDashboardState.loading());
      if(showLoadingListOnly) emit(const PageDashboardState.loadingListOnlySpace());

      textSearchFieldController.text = mapQueryParams['q'] ?? '';


      ApiResponse res = await _eventsRepository.getEventosHasLatLng(mapQueryParams);
      if(res.ok){
        SucessoEventosResponse sucessoEventosResponse =  res.result as SucessoEventosResponse;
        List<Evento>? results = sucessoEventosResponse.eventos;
        if(results!.isEmpty){
          emit(const PageDashboardState.successWithListEmpty());
          return;
        }
        emit(PageDashboardState.success(results));
      }
      emit(PageDashboardState.error(res.result));

    } on SocketException {
      emit(const PageDashboardState.offline());
    } catch (exception) {
      emit(PageDashboardState.error(exception.toString()));
    }
  }

  void search(String value) async {

    _eventsRepository.getEventosSearch(qParamsTextSearch: value);
  }

}
