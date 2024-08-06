import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:runtickets_web/core/constants/share_preferece_constants.dart';
import 'package:runtickets_web/models/responses/success_get_event_categorias_response.dart';
import 'package:runtickets_web/models/responses/success_get_events_response.dart';
import 'package:runtickets_web/utils/app_config.dart';

import '../models/api_response.dart';
import '../services/location_service.dart';
import '../services/shared_preference_service.dart';

class EventsRepository {

  http.Client client;
  final LocationService _locationService;
  final SharedPreferenceService _preferenceService;

  EventsRepository(this.client, this._locationService, this._preferenceService);

  Future<ApiResponse> getEventoCategoria() async {
    Map<String, dynamic>? dataSubscription =
    await _preferenceService.getCurrentDataSubscription();
    String? eventId = dataSubscription?[DataSubscription.eventId].toString();

    Uri url = Uri.parse("$baseUrl/api/v1/evento-categoria/?order=desc&orderby=pk&evento=9");

    Response response = await client.get(url,
        headers: {
          "Content-Type": "application/json"
        }
    );


    if(response.statusCode == 200){
      var res = json.decode(utf8.decode(response.bodyBytes));
      GetEventCategoriaResponse getEventCategoriaResponse = GetEventCategoriaResponse.fromJson(res);
      return ApiResponse.ok(getEventCategoriaResponse);
    }else{
      return ApiResponse.error(response.statusCode, msg: response.body);
    }

  }

  Future<ApiResponse> getEventosSearch({String? qParamsTextSearch}) async {

    bool searchMode = qParamsTextSearch != null;

    Uri url = Uri.parse("$baseUrl/api/v1/evento/")
        .replace(queryParameters: {
      'page': '1',
      'limit': '10',
      'order': 'desc',
      'orderby': 'dataevento',
      if(searchMode)
        'q': qParamsTextSearch,
    });

    Response response = await client.get(url,
        headers: {
          "Content-Type": "application/json"
        }
    );
    if(response.statusCode != 200){
      return ApiResponse.error('');
    }
    var res = json.decode(utf8.decode(response.bodyBytes));
    SucessoEventosResponse sucessoEventosResponse = SucessoEventosResponse.fromJson(res);

    return ApiResponse.ok(sucessoEventosResponse);
  }

  Future<ApiResponse> getEventosHasLatLng(Map<String, dynamic> mapQueryParams) async {

    // var locationDetails = await _locationService.getLocationDetails();

    Uri url = Uri.parse("$baseUrl/api/v1/evento/")
        .replace(queryParameters: mapQueryParams);

    Response response = await get(url,
        headers: {
          "Content-Type": "application/json"
        }
    );

    print(response.body);
    if(response.statusCode != 200){
      return ApiResponse.error('');
    }
    var res = json.decode(utf8.decode(response.bodyBytes));
    SucessoEventosResponse sucessoEventosResponse = SucessoEventosResponse.fromJson(res);

    return ApiResponse.ok(sucessoEventosResponse);
  }


  Future<ApiResponse> getEventById(int id) async {
    Uri url = Uri.parse("$baseUrl/api/v1/evento/?pk=$id");

    Response response = await client.get(url,
        headers: {
          "Content-Type": "application/json"
        }
    );
    if(response.statusCode != 200){
      return ApiResponse.error('');
    }

    if(response.statusCode == 200){
      var res = json.decode(utf8.decode(response.bodyBytes));
      Evento results = Evento.fromJson(res);
      return ApiResponse.ok(results);
    }else{
      return ApiResponse.error(response.statusCode, msg: response.body);
    }
  }
}