import 'package:flutter/material.dart';

class VenueListScreen extends StatelessWidget {
  const VenueListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual venue data from Firebase
    final List<Map<String, dynamic>> venues = [
      {
        'name': 'The Grand Hall',
        'address': '123 Main Street, Downtown',
        'rating': 4.5,
        'imageUrl': 'https://picsum.photos/seed/venue1/400/200',
        'eventCount': 3,
        'description': 'A luxurious venue perfect for large gatherings and corporate events.',
        'capacity': 500,
        'amenities': ['Parking', 'WiFi', 'Catering', 'AV Equipment'],
        'priceRange': 'money',
      },
      {
        'name': 'Riverside Convention Center',
        'address': '456 River Road',
        'rating': 4.8,
        'imageUrl': 'https://picsum.photos/seed/venue2/400/200',
        'eventCount': 5,
        'description': 'Modern convention center with state-of-the-art facilities.',
        'capacity': 1000,
        'amenities': ['Parking', 'WiFi', 'In-house Catering', 'Technical Support'],
        'priceRange': "money",
      },
      {
        'name': 'The Modern Gallery',
        'address': '789 Art Avenue',
        'rating': 4.2,
        'imageUrl': 'https://picsum.photos/seed/venue3/400/200',
        'eventCount': 2,
        'description': 'A modern gallery with a focus on contemporary art.',
        'capacity': 200,
        'amenities': ['Parking', 'WiFi', 'Art Gallery'],
        'priceRange': 'ubermoney',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Venues',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
              // Search by name, location, capacity, etc.
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter functionality
              // Filter by: price range, capacity, amenities, etc.
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: InkWell(
              onTap: () {
                // TODO: Navigate to venue details screen
                // Show detailed information about the venue:
                // - Available dates
                // - Booking process
                // - Reviews
                // - Photo gallery
                // - Contact information
                // - Detailed amenities list
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Image.network(
                          venue['imageUrl'],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 200,
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            venue['priceRange'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              venue['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    venue['rating'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on, 
                                size: 16, 
                                color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                venue['address'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Capacity: ${venue['capacity']} people',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              '${venue['eventCount']} Upcoming Events',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to venue details
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              child: const Text('View Details'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}