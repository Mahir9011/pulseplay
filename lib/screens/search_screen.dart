import 'package:flutter/material.dart';
import 'package:pulseplay/services/ytmusic_service.dart'; // Import the YTMusicService
import 'package:pulseplay/widgets/player.dart'; // Import the Player widget

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key}); // Add a named 'key' parameter

  @override
  SearchScreenState createState() =>
      SearchScreenState(); // Make the state class public
}

class SearchScreenState extends State<SearchScreen> {
  final YTMusicService _ytMusicService = YTMusicService();
  List<dynamic> _searchResults = []; // Stores the search results
  String? _currentAudioUrl; // Track the currently playing audio URL

  // Function to search for songs
  Future<void> _searchSongs(String query) async {
    try {
      final results =
          await _ytMusicService.searchSongs(query); // Call the Python script
      setState(() {
        _searchResults = results; // Update the search results
      });
    } catch (e) {
      // Use debugPrint instead of print
      debugPrint('Error searching songs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search for songs...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            _searchSongs(
                value); // Trigger the search when the user submits the query
          },
        ),
      ),
      body: _searchResults.isEmpty
          ? const Center(
              child: Text(
                'No results found',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final song = _searchResults[index];
                return ListTile(
                  leading: song['albumArtUrl'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            song['albumArtUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.music_note, color: Colors.white),
                  title: Text(
                    song['title'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    song['artist'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () async {
                    // Fetch the audio stream URL and play the song
                    final audioUrl =
                        await _ytMusicService.getAudioStreamUrl(song['id']);
                    if (audioUrl != null) {
                      setState(() {
                        _currentAudioUrl = audioUrl;
                      });
                    }
                  },
                );
              },
            ),
      bottomNavigationBar:
          _currentAudioUrl != null ? Player(audioUrl: _currentAudioUrl!) : null,
    );
  }
}
