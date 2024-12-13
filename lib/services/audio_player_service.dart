import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart'; // Import logger

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Logger _logger = Logger(); // Initialize logger

  // Play a song
  Future<void> play(String audioUrl) async {
    try {
      await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.play();
    } catch (e) {
      _logger.e("Error playing audio: $e");
    }
  }

  // Pause the currently playing song
  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      _logger.e("Error pausing audio: $e");
    }
  }

  // Skip to the next song
  Future<void> skipNext() async {
    // Implement logic to skip to the next song in the queue
    _logger.i("Skipping to the next song");
  }

  // Skip to the previous song
  Future<void> skipPrevious() async {
    // Implement logic to skip to the previous song in the queue
    _logger.i("Skipping to the previous song");
  }

  // Seek to a specific position in the song
  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      _logger.e("Error seeking audio: $e");
    }
  }

  // Dispose the audio player
  void dispose() {
    _audioPlayer.dispose();
  }
}
