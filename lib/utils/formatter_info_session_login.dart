import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

String formatLoginNotification({
  required DateTime dateTime,
  required String location,
  required String ipAddress,
  required String deviceType,
  required String os,
  required String browser,
  required String deviceName,
  required String connectionType,
}) {
  // Formata a data e hora
  String dateTimeStr = "${dateTime.day} de ${_getMonthName(dateTime.month)} de ${dateTime.year}, às ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";

  // Usa um delimitador para separar os dados
  String delimiter = "|";

  // Cria a mensagem formatada
  String message = "Novo Login em seu Dispositivo\n\n"
      "Data e Hora: $dateTimeStr$delimiter"
      "Localização: $location$delimiter"
      "Endereço IP: $ipAddress$delimiter"
      "Tipo de Dispositivo: $deviceType$delimiter"
      "Sistema Operacional: $os$delimiter"
      "Navegador: $browser$delimiter"
      "Nome do Dispositivo: $deviceName$delimiter"
      "Conexão: $connectionType\n\n";

  return message;
}

Future<String> getIPAddress() async {
  try {
    final response = await http.get(Uri.parse('https://api64.ipify.org?format=json'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['ip'];
    } else {
      throw Exception('Failed to get IP address');
    }
  } catch (e) {
    return "Desconhecido";
  }
}

Future<String> getConnectionType() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  switch (connectivityResult) {
    case ConnectivityResult.wifi:
      return "Wi-Fi";
    case ConnectivityResult.mobile:
      return "Dados Móveis";
    case ConnectivityResult.none:
      return "Sem Conexão";
    default:
      return "Desconhecido";
  }
}

String _getMonthName(int month) {
  const List<String> monthNames = [
    "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
    "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
  ];
  return monthNames[month - 1];
}

Future<Map<String, String>> getDeviceDetails() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String deviceType;
  String osName;
  String browserName = "Desconhecido";
  String deviceName = "Desconhecido";
  String location = "Desconhecido";

  // Verifica se está rodando no Android
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    deviceType = "Smartphone";
    osName = "Android ${androidInfo.version.release}";
    deviceName = androidInfo.model;
  }
  // Verifica se está rodando no iOS
  else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    deviceType = "Smartphone";
    osName = "${iosInfo.systemName} ${iosInfo.systemVersion}";
    deviceName = iosInfo.utsname.machine; // i.e. model identifier
  }
  // Verifica se está rodando na Web
  else if (kIsWeb) {
    WebBrowserInfo webInfo = await deviceInfoPlugin.webBrowserInfo;
    deviceType = "Web";
    osName = webInfo.browserName.name;
    browserName = webInfo.browserName.name;
    deviceName = webInfo.userAgent ?? "Desconhecido";
  }
  // Verifica se está rodando em um Desktop
  else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    deviceType = "Desktop";
    osName = _platformName();
    // Obter o nome do dispositivo em desktops pode ser complexo e específico por SO.
  } else {
    deviceType = "Desconhecido";
    osName = "Desconhecido";
  }


  String ipAddress = await getIPAddress();
  String connectionType = await getConnectionType();

  return {
    "deviceType": deviceType,
    "osName": osName,
    "browserName": browserName,
    "deviceName": deviceName,
    "ipAddress": ipAddress,
    "connectionType": connectionType,
  };
}

String _platformName() {
  if (Platform.isMacOS) return "macOS";
  if (Platform.isWindows) return "Windows";
  if (Platform.isLinux) return "Linux";
  return "Desconhecido";
}


