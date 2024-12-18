import 'package:google_maps_webservice/google_maps_webservice.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsService {
  final GoogleMapsPlaces _places;
  final loc.Location _location;
  
  MapsService({GoogleMapsPlaces? places, loc.Location? location})
      : _places = places ?? GoogleMapsPlaces(apiKey: 'YOUR_GOOGLE_MAPS_API_KEY'),
        _location = location ?? loc.Location();
  
  Future<List<PlacePrediction>> searchLocation(String query) async {
    try {
      final response = await _places.autocomplete(
        query,
        language: 'en',
      );

      if (response.isOkay) {
        return response.predictions
            .map((prediction) => PlacePrediction(
                  placeId: prediction.placeId,
                  description: prediction.description,
                  mainText: prediction.structuredFormatting?.mainText ?? '',
                  secondaryText: prediction.structuredFormatting?.secondaryText ?? '',
                ))
            .toList();
      }
      
      throw Exception('Place autocomplete request failed');
    } catch (e) {
      throw Exception('Failed to search location: $e');
    }
  }
  
  Future<LocationData> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        final result = await _location.requestService();
        if (!result) {
          throw Exception('Location services are disabled');
        }
      }

      // Check for location permissions
      var permission = await _location.hasPermission();
      if (permission == loc.PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission != loc.PermissionStatus.granted) {
          throw Exception('Location permissions are denied');
        }
      }

      // Get location
      final locationData = await _location.getLocation();
      return LocationData(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
    } catch (e) {
      throw Exception('Failed to get current location: $e');
    }
  }
} 

class PlacePrediction {
  final String placeId;
  final String description;
  final String mainText;
  final String secondaryText;

  PlacePrediction({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
  });
}

class LocationData {
  final double latitude;
  final double longitude;

  LocationData({
    required this.latitude,
    required this.longitude,
  });
} 