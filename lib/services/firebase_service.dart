import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';
import '../models/venue.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Events
  Future<void> createEvent(Map<String, dynamic> eventData) async {
    try {
      await _db.collection('events').add(eventData);
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  Stream<List<Event>> getEvents() {
    return _db.collection('events')
        .orderBy('dateTime')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Event.fromFirestore(doc))
            .toList());
  }

  // Venues
  Future<void> createVenue(Map<String, dynamic> venueData) async {
    try {
      await _db.collection('venues').add(venueData);
    } catch (e) {
      throw Exception('Failed to create venue: $e');
    }
  }

  Stream<List<Venue>> getVenues() {
    return _db.collection('venues')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Venue.fromFirestore(doc))
            .toList());
  }
} 