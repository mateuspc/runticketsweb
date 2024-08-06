import 'dart:convert';
import 'package:runtickets_web/core/constants/share_preferece_constants.dart';
import 'package:runtickets_web/models/responses/success_login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _sharedPreferences;

  SharedPreferenceService(this._sharedPreferences);

  static const String _userMap = "user_map";

  Future<void> clear() async {
    _sharedPreferences.clear();
  }

  Future<bool> setCurrentEmail(String currentEmail) async {
    var res =  await _sharedPreferences.setString(InfoUserConstants.currentEmail, currentEmail);
    return res;
  }

  String? getCurrentEmail() {
    String? res =  _sharedPreferences.getString(InfoUserConstants.currentEmail);
    return res;
  }

  Future<bool> setTokenFcm(String currentEmail) async {
    var res =  await _sharedPreferences.setString(InfoUserConstants.tokenFcm, currentEmail);
    return res;
  }

  String? getTokenFcm() {
    String? res =  _sharedPreferences.getString(InfoUserConstants.tokenFcm);
    return res;
  }

  Future<bool> saveCurrentDataSubscription(Map<String, dynamic> jsonData) async {
    final String jsonString = json.encode(jsonData);
    return await _sharedPreferences.setString(DataSubscription.currentSubscription, jsonString);
  }

  Future<Map<String, dynamic>?> getCurrentDataSubscription() async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    if (jsonString != null) {
      return json.decode(jsonString);
    }
    return null;
  }
  Future<void> addIdInscricao(int inscricaoId) async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    if (jsonString != null) {
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      jsonData[DataSubscription.inscricaoId] = inscricaoId;
      saveCurrentDataSubscription(jsonData);
    }
  }

  Future<void> addIdEvento(int eventId) async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    if (jsonString != null) {
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      jsonData[DataSubscription.eventId] = eventId;
      saveCurrentDataSubscription(jsonData);
    }
  }
  Future<void> addRoute(String? route) async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    if (jsonString != null) {
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      jsonData[DataSubscription.route] = route;
      saveCurrentDataSubscription(jsonData);
    }
  }

  Future<void> addCategory(String? eventCategoryId) async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    if (jsonString != null) {
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      jsonData[DataSubscription.eventCategoryId] = eventCategoryId;
      saveCurrentDataSubscription(jsonData);
    }
  }

  Future<void> addCreditCard(String? creditCardIdSelected) async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    if (jsonString != null) {
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      jsonData[DataSubscription.creditCardSelected] = creditCardIdSelected;
      saveCurrentDataSubscription(jsonData);
    }
  }

  Future<bool> addMinParcelaCartao(int? creditCardIdSelected) async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    try{
      if (jsonString != null) {
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        jsonData[DataSubscription.minParcela] = creditCardIdSelected;
        saveCurrentDataSubscription(jsonData);
        return true;
      }
      return false;
    }catch(e){
      return false;
    }

  }

  Future<bool> addMaxParcelaCartao(int? creditCardIdSelected) async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    try{
      if (jsonString != null) {
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        jsonData[DataSubscription.maxParcela] = creditCardIdSelected;
        saveCurrentDataSubscription(jsonData);
        return true;
      }
      return false;
    }catch(e){
      return false;
    }
  }
  Future<bool> addModality(String? modalityId) async {
    final String? jsonString = _sharedPreferences.getString(DataSubscription.currentSubscription);
    try{
      if (jsonString != null) {
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        jsonData[DataSubscription.modalidadeId] = modalityId;
        await saveCurrentDataSubscription(jsonData);
      }
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> cleanInscriptionPrefs() async {
    return saveCurrentDataSubscription({});
  }
  Future<bool> setUser(CurrentUser response) async {
    var res =  await _sharedPreferences.setString(
        _userMap, jsonEncode(response.toJson()));
    return res;
  }

  CurrentUser? getUser() {
    try {
      return CurrentUser.fromJson(jsonDecode(_sharedPreferences.getString(_userMap)!));
    } catch (e) {
      _sharedPreferences.remove(_userMap);
      return null;
    }
  }

  String sessionId(){
    try{
      CurrentUser currentUser = getUser()!;
      return currentUser.sessionid ?? '';
    }catch(e){
      return '';
    }
  }
}
