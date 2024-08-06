
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;

class LocationService {

  Future<Map<String, String>> getLocationDetails() async {
    String location = "Desconhecido";

    Position position = await determinePosition();
    if (position.latitude != 0 && position.longitude != 0) {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        location = "${place.administrativeArea}, ${place.country}";
      }
    }

    return {
      "latitude": position.latitude.toString(),
      "longitude": position.longitude.toString(),
      "location": location,
    };
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se os serviços de localização estão habilitados.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return _defaultPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return _defaultPosition();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return _defaultPosition();
    }

    // Quando os serviços de localização e permissões estiverem garantidos, obtenha a posição atual do dispositivo.
    return await Geolocator.getCurrentPosition();
  }

  Position _defaultPosition() {
    return Position(
      latitude: 0,
      longitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  }


  void openMapsSheet(context,
      double latitudeLargada,
      double longitudeLargada,
      double latitudeDestination,
      double longitudeDestionation) async {
    try {
      final coordsLargada = launcher.Coords(latitudeLargada, longitudeLargada);
      final coordsChegada = launcher.Coords(latitudeDestination, longitudeDestionation);
      final availableMaps = await launcher.MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Abrir com:', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800
                    ),),
                  ),
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showDirections(
                        directionsMode: launcher.DirectionsMode.driving,
                        destinationTitle: 'Chegada',
                        originTitle: 'Largada',
                        origin: coordsLargada,
                        destination: coordsChegada,
                      ),
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      return null;
    }
  }
}
