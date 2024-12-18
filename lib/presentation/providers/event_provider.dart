import 'package:flutter/foundation.dart';
import 'package:hyper_local_socialization_app/data/repositories/event_repository.dart';
import 'package:hyper_local_socialization_app/data/models/event.dart';

class EventProvider with ChangeNotifier {
  final EventRepository eventRepository;
  List<Event> _events = [];

  EventProvider({required this.eventRepository});

  List<Event> get events => _events;

  Future<List<Event>> getEvents() async {
    _events = await eventRepository.fetchEvents();
    notifyListeners();
    return _events;
  }

  Future<void> createEvent(Event event) async {
    await eventRepository.addEvent(event);
    await getEvents(); // Refresh the events list
    notifyListeners();
  }
} 