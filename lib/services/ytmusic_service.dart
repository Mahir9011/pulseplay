import 'package:flutter/services.dart';
import 'dart:convert';

class YTMusicService {
  static const platform = MethodChannel('com.pulseplay/ytmusic');

  // Search for songs
  Future<List<dynamic>> searchSongs(String query) async {
    try {
      final String result = await platform.invokeMethod('searchSongs', query);
      final List<dynamic> data = jsonDecode(result);
      return data.map((song) {
        return {
          'id': song['videoId'],
          'title': song['title'],
          'artist': song['artists'][0]['name'],
          'duration':
              Duration(seconds: int.parse(song['duration_seconds'].toString())),
          'albumArtUrl': song['thumbnails'][0]['url'],
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to search songs: $e');
    }
  }

  // Fetch audio stream URL for a song
  Future<String?> getAudioStreamUrl(String videoId) async {
    try {
      final String result =
          await platform.invokeMethod('getAudioStreamUrl', videoId);
      return result;
    } catch (e) {
      throw Exception('Failed to fetch audio stream: $e');
    }
  }
}
