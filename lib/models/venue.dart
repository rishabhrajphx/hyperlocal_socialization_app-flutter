import 'package:cloud_firestore/cloud_firestore.dart';

class Venue {
  final String id;
  final String name;
  final String address;
  final String description;
  final int capacity;
  final List<String> amenities;
  final Map<String, dynamic> location; // For storing GeoPoint
  final String? imageUrl;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.capacity,
    required this.amenities,
    required this.location,
    this.imageUrl,
  });

  factory Venue.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Venue(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      description: data['description'] ?? '',
      capacity: data['capacity'] ?? 0,
      amenities: List<String>.from(data['amenities'] ?? []),
      location: data['location'] ?? {},
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'capacity': capacity,
      'amenities': amenities,
      'location': location,
      'imageUrl': imageUrl,
    };
  }
} 