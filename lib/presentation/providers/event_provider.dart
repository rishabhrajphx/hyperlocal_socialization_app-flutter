import 'package:flutter/foundation.dart';
import 'package:hyper_local_socialization_app/data/repositories/event_repository.dart';
import 'package:hyper_local_socialization_app/data/models/event.dart';
import 'dart:async';

class EventProvider with ChangeNotifier {
  final EventRepository eventRepository;
  List<Event> _events = [];
  final StreamController<List<Event>> _eventsController =
      StreamController<List<Event>>.broadcast();

  EventProvider({required this.eventRepository}) {
    // Fetch initial events
    fetchAndAddEventsToStream();
  }

  Stream<List<Event>> get eventsStream => _eventsController.stream;

  Future<void> fetchAndAddEventsToStream() async {
    try {
      _events = await eventRepository.fetchEvents();
      _eventsController.add(_events);
      notifyListeners();
    } catch (e) {
      _eventsController.addError(e);
    }
  }

  Future<List<Event>> getEvents() async {
    await fetchAndAddEventsToStream();
    return _events;
  }

  Future<void> createEvent(Event event) async {
    await eventRepository.addEvent(event);
    await fetchAndAddEventsToStream(); // Refresh the events list
    notifyListeners();
  }

  @override
  void dispose() {
    _eventsController.close();
    super.dispose();
  }
}
