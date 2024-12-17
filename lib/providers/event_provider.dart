import 'package:flutter/foundation.dart';
import '../services/firebase_service.dart';
import '../models/event.dart';

class EventProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Event> _events = [];

  List<Event> get events => _events;

  Stream<List<Event>> getEvents() {
    return _firebaseService.getEvents();
  }

  Future<void> createEvent(Event event) async {
    await _firebaseService.createEvent(event.toMap());
    notifyListeners();
  }
} 