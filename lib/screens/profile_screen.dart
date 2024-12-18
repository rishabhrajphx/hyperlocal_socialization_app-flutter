import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//flighty
class ProfileScreen extends StatelessWidget { 
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual user data from Firebase
    final Map<String, dynamic> user = {
      'name': 'John Doe',
      'imageUrl': 'https://picsum.photos/seed/profile/400/400',
      'eventsAttended': 12,
      'friends': 234,
      'bio': 'Adventure seeker & event enthusiast',
    };

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pencil),
            onPressed: () {
              // TODO: Navigate to edit profile screen
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.settings),
            onPressed: () {
              // TODO: Navigate to settings screen
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          // Profile Header
          Center(
            child: Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      user['imageUrl'],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user['name'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user['bio'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('Events', user['eventsAttended'].toString()),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey[300],
                ),
                _buildStatColumn('Friends', user['friends'].toString()),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement invite friends functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Invite Friends'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Past Events Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Past Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildPastEventsList(),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPastEventsList() {
    // TODO: Replace with actual past events data from Firebase
    final List<Map<String, dynamic>> pastEvents = [
      {
        'name': 'Summer Music Festival',
        'date': '2024-03-15',
        'imageUrl': 'https://picsum.photos/seed/event1/400/200',
      },
      {
        'name': 'Tech Conference 2024',
        'date': '2024-02-28',
        'imageUrl': 'https://picsum.photos/seed/event2/400/200',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: pastEvents.length,
      itemBuilder: (context, index) {
        final event = pastEvents[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                event['imageUrl'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              event['name'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              event['date'],
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            trailing: const Icon(CupertinoIcons.chevron_right),
            onTap: () {
              // TODO: Navigate to event details
            },
          ),
        );
      },
    );
  }
}