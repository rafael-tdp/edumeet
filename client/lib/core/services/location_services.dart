import 'package:location/location.dart';

class LocationService {
  static Future<Map<String, double>> getLocation() async {
    try {
      // Initialiser le package de localisation
      final location = Location();

      // Vérifier si le service de localisation est activé
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Exception("Service de localisation désactivé.");
        }
      }

      // Vérifier les permissions
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw Exception("Permission de localisation refusée.");
        }
      }

      // Récupérer la localisation actuelle
      final currentLocation = await location.getLocation();

      // Vérifier si les données sont nulles
      if (currentLocation.latitude == null ||
          currentLocation.longitude == null) {
        throw Exception("Impossible de récupérer la localisation.");
      }

      // Retourner les coordonnées
      return {
        "latitude": currentLocation.latitude!,
        "longitude": currentLocation.longitude!,
      };
    } catch (error) {
      print("Erreur lors de la récupération de la localisation: $error");
      rethrow;
    }
  }
}
