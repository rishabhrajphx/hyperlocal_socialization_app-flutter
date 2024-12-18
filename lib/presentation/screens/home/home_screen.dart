import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../models/event.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Search bar for locations
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a city or area',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // TODO: Implement location search functionality
                // - Add autocomplete for cities and areas
                // - Integrate with Google Places API
                // - Save recent searches
              ),
              const SizedBox(height: 16),
              // Current location option
              ListTile(
                leading: const Icon(Icons.my_location),
                title: const Text('Use current location'),
                onTap: () {
                  // TODO: Implement current location detection
                  // - Request location permissions
                  // - Get current coordinates
                  // - Reverse geocode to get address
                  // - Update app state with new location
                  Navigator.pop(context);
                },
              ),
              // Recent locations
              const Text(
                'Recent Locations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    // TODO: Implement recent locations list
                    // - Store recently selected locations in local storage
                    // - Allow quick selection of previous locations
                    // - Add option to remove locations from history
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text('New York, NY'),
                      onTap: () {
                        // TODO: Implement location selection
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Events',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on, color: Colors.black),
            onPressed: () => _showLocationPicker(context),
          ),
        ],
      ),
      body: StreamBuilder<List<Event>>(
        stream: Provider.of<EventProvider>(context).getEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data ?? [];
          
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Happening Near You',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'New York, NY',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => EventCard(event: events[index]),
                    childCount: events.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// TODO: Add location indicator banner
// - Show current selected location
// - Add distance radius selector
// - Show number of events in area

          
/* Future Improvements:
 * 1. Location Services:
 *    - Implement geofencing for local event notifications
 *    - Add distance filtering options
 *    - Show events on a map view
 *
 * 2. Filtering and Sorting:
 *    - Add category filters
 *    - Sort by date, popularity, or distance
 *    - Price range filters
 *
 * 3. Social Features:
 *    - Allow users to share their location with friends
 *    - Show events that friends are attending
 *    - Group planning features
 *
 * 4. Performance Optimizations:
 *    - Cache location data
 *    - Implement pagination for event list
 *    - Background location updates
 *
 * 5. Analytics:
 *    - Track popular locations
 *    - Monitor search patterns
 *    - Analyze user movement patterns
 */ 