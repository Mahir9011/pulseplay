import 'package:flutter/material.dart';
import 'package:pulseplay/screens/search_screen.dart'; // Import the SearchScreen

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.black,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'PulsePlay',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Home
            },
          ),
          ListTile(
            leading: const Icon(Icons.search, color: Colors.white),
            title: const Text('Search', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to SearchScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_music, color: Colors.white),
            title: const Text('Your Library',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Library
            },
          ),
        ],
      ),
    );
  }
}
