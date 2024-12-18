import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hyper_local_socialization_app/data/models/event.dart';

class EventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'events';

  Future<List<Event>> fetchEvents() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection(_collection).get();
      return snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      await _firestore.collection(_collection).add(event.toMap());
    } catch (e) {
      print('Error adding event: $e');
      throw Exception('Failed to add event');
    }
  }

  Future<void> updateEvent(Event event) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(event.id)
          .update(event.toMap());
    } catch (e) {
      print('Error updating event: $e');
      throw Exception('Failed to update event');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection(_collection).doc(eventId).delete();
    } catch (e) {
      print('Error deleting event: $e');
      throw Exception('Failed to delete event');
    }
  }
}