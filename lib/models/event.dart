class Event {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String organizerId;
  final String? venueId;
  final double price;
  final int maxAttendees;
  final List<String> attendeeIds;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.organizerId,
    this.venueId,
    required this.price,
    required this.maxAttendees,
    required this.attendeeIds,
  });
}

// Dummy data for testing
final List<Event> dummyEvents = [
  Event(
    id: '1',
    title: 'Local Music Night',
    description: 'Join us for a night of local music talents!',
    dateTime: DateTime.now().add(const Duration(days: 2)),
    location: 'Downtown Music Hall',
    organizerId: 'user1',
    price: 15.0,
    maxAttendees: 100,
    attendeeIds: [],
  ),
  // Add more dummy events as needed
]; 