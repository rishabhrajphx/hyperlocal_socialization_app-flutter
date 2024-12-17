import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Event(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      location: data['location'] ?? '',
      organizerId: data['organizerId'] ?? '',
      venueId: data['venueId'],
      price: (data['price'] ?? 0).toDouble(),
      maxAttendees: data['maxAttendees'] ?? 0,
      attendeeIds: List<String>.from(data['attendeeIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dateTime': Timestamp.fromDate(dateTime),
      'location': location,
      'organizerId': organizerId,
      'venueId': venueId,
      'price': price,
      'maxAttendees': maxAttendees,
      'attendeeIds': attendeeIds,
    };
  }
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
  Event(
    id: '2',
    title: 'Tech Meetup 2024',
    description: 'Network with local tech professionals and learn about the latest trends',
    dateTime: DateTime.now().add(const Duration(days: 5)),
    location: 'Innovation Hub',
    organizerId: 'user2',
    price: 0.0,
    maxAttendees: 50,
    attendeeIds: ['user1', 'user3'],
  ),
  Event(
    id: '3',
    title: 'Food Festival',
    description: 'Experience cuisines from around the world',
    dateTime: DateTime.now().add(const Duration(days: 7)),
    location: 'City Park',
    organizerId: 'user3',
    venueId: 'venue1',
    price: 25.0,
    maxAttendees: 500,
    attendeeIds: [],
  ),
  Event(
    id: '4',
    title: 'Yoga in the Park',
    description: 'Start your morning with relaxing yoga session',
    dateTime: DateTime.now().add(const Duration(days: 1)),
    location: 'Central Park',
    organizerId: 'user4',
    price: 10.0,
    maxAttendees: 30,
    attendeeIds: ['user2'],
  ),
]; 