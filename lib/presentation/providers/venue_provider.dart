import 'package:flutter/foundation.dart';
import 'package:hyper_local_socialization_app/data/services/firebase_service.dart';
import 'package:hyper_local_socialization_app/data/models/venue.dart';

class VenueProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Venue> _venues = [];

  List<Venue> get venues => _venues;

  Stream<List<Venue>> getVenues() {
    return _firebaseService.getVenues();
  }

  Future<void> createVenue(Venue venue) async {
    await _firebaseService.createVenue(venue.toMap());
    notifyListeners();
  }
} 