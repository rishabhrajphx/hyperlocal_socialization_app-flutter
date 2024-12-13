import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../models/event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              // TODO: Implement location selection
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyEvents.length,
        itemBuilder: (context, index) {
          return EventCard(event: dummyEvents[index]);
        },
      ),
    );
  }
} 