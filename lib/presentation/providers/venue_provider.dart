import 'package:flutter/foundation.dart';
import 'package:hyper_local_socialization_app/data/repositories/venue_repository.dart';
import 'package:hyper_local_socialization_app/data/models/venue.dart';

class VenueProvider with ChangeNotifier {
  final VenueRepository venueRepository;
  List<Venue> _venues = [];

  VenueProvider({required this.venueRepository});

  List<Venue> get venues => _venues;

  Future<List<Venue>> getVenues() async {
    _venues = await venueRepository.fetchVenues();
    notifyListeners();
    return _venues;
  }

  Future<void> createVenue(Venue venue) async {
    await venueRepository.addVenue(venue);
    await getVenues(); // Refresh the venues list
    notifyListeners();
  }
} 