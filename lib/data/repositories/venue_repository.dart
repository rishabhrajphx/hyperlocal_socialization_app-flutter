import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hyper_local_socialization_app/data/models/venue.dart';

class VenueRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'venues';

  Future<List<Venue>> fetchVenues() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection(_collection).get();
      return snapshot.docs.map((doc) => Venue.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching venues: $e');
      return [];
    }
  }

  Future<void> addVenue(Venue venue) async {
    try {
      await _firestore.collection(_collection).add(venue.toMap());
    } catch (e) {
      print('Error adding venue: $e');
      throw Exception('Failed to add venue');
    }
  }

  Future<void> updateVenue(Venue venue) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(venue.id)
          .update(venue.toMap());
    } catch (e) {
      print('Error updating venue: $e');
      throw Exception('Failed to update venue');
    }
  }

  Future<void> deleteVenue(String venueId) async {
    try {
      await _firestore.collection(_collection).doc(venueId).delete();
    } catch (e) {
      print('Error deleting venue: $e');
      throw Exception('Failed to delete venue');
    }
  }
}