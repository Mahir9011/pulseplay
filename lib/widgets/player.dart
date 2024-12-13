import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseplay/services/audio_player_service.dart'; // Import the audio player service

class Player extends ConsumerStatefulWidget {
  final String audioUrl; // Pass the audio URL to the player

  const Player({super.key, required this.audioUrl});

  @override
  ConsumerState<Player> createState() => _PlayerState();
}

class _PlayerState extends ConsumerState<Player> {
  late AudioPlayerService _audioPlayerService;

  @override
  void initState() {
    super.initState();
    _audioPlayerService = AudioPlayerService();
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      height: 80,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                'https://via.placeholder.com/50',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Song Title',
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                'Artist Name',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                onPressed: () {
                  _audioPlayerService.skipPrevious();
                },
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                onPressed: () {
                  _audioPlayerService.play(widget.audioUrl);
                },
              ),
              IconButton(
                icon: const Icon(Icons.pause, color: Colors.white),
                onPressed: () {
                  _audioPlayerService.pause();
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                onPressed: () {
                  _audioPlayerService.skipNext();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
