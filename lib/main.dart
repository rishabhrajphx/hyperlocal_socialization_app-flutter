import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Config
import 'config/theme.dart';

// Providers
import 'presentation/providers/event_provider.dart';
import 'presentation/providers/venue_provider.dart';
import 'presentation/providers/auth_provider.dart';

// Repositories
import 'data/repositories/user_repository.dart';
import 'data/repositories/event_repository.dart';
import 'data/repositories/venue_repository.dart';

// Screens
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/events/event_creation_screen.dart';
import 'presentation/screens/venue/venue_list_screen.dart';
import 'presentation/screens/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LocalEventsApp());
}

class LocalEventsApp extends StatelessWidget {
  const LocalEventsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Repositories
        Provider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        Provider<EventRepository>(
          create: (_) => EventRepository(),
        ),
        Provider<VenueRepository>(
          create: (_) => VenueRepository(),
        ),

        // Providers
        ChangeNotifierProvider<AuthProvider>(
          create: (context) {
            final userRepository = context.read<UserRepository>();
            return AuthProvider(userRepository: userRepository);
          },
        ),
        ChangeNotifierProvider<EventProvider>(
          create: (context) {
            final eventRepository = context.read<EventRepository>();
            return EventProvider(eventRepository: eventRepository);
          } 
        ),
        ChangeNotifierProvider<VenueProvider>(
          create: (context) {
            final venueRepository = context.read<VenueRepository>();
            return VenueProvider(venueRepository: venueRepository);
          } 
        ),
      ],
      child: MaterialApp(
        title: 'Local Events',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const MainNavigationScreen(),
        // routes: AppRoutes.routes, // Uncomment when routes are implemented
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const EventCreationScreen(),
    const VenueListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          NavigationDestination(
            icon: Icon(Icons.store_outlined),
            selectedIcon: Icon(Icons.store),
            label: 'Venues',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
