
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runtickets_web/models/api_response.dart';
import 'package:runtickets_web/services/location_service.dart';
import '../../data/events_repository.dart';
import 'page_detalhes_corrida_state.dart';

class PageCorridaDetalhesCubit extends Cubit<PageDetalhesCorridaState> {

  final EventsRepository _dashboardRepository;
  final LocationService _locationRepository;

  PageCorridaDetalhesCubit(this._dashboardRepository,
      this._locationRepository) : super(const PageDetalhesCorridaState.initial());

  void getEventById(int id) async {
    try{
      emit(const PageDetalhesCorridaState.loading());

      ApiResponse apiResponse = await _dashboardRepository.getEventById(id);
      if(apiResponse.ok){
        emit(PageDetalhesCorridaState.success(apiResponse.result));
      }else{
        emit(const PageDetalhesCorridaState.error('error'));
      }
    }
    on SocketException {
      emit(const PageDetalhesCorridaState.offline());
    }
    catch(e){
      emit(const PageDetalhesCorridaState.error('error'));

    }
  }

  void openMaps(BuildContext context,double latitudeDestination,
      double longitudeDestionation,
      {required double latitudeLargada,
        required double longitudeLargada}){
    _locationRepository.openMapsSheet(context,
        latitudeLargada, longitudeLargada,
        latitudeDestination, longitudeDestionation );
  }


}