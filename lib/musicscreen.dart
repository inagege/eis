import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, String>> _playlist = [
    {"title": "Heart", "file": "assets/music/heart.mp3"},
    {"title": "Hope", "file": "assets/music/hope.mp3"},
    {"title": "Yesterday", "file": "assets/music/yesterday.mp3"},
  ];

  String? _currentSong;
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playMusic(String file) async {
    if (_currentSong != file) {
      await _audioPlayer.stop();
      int result = await _audioPlayer.play(file);
      if (result == 1) {
        setState(() {
          _currentSong = file;
          _isPlaying = true;
        });
      }
    } else if (!_isPlaying) {
      await _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<void> _pauseMusic() async {
    int result = await _audioPlayer.pause();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  Future<void> _stopMusic() async {
    int result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
        _currentSong = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entspannungsmusik Playlist'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _playlist.length,
              itemBuilder: (context, index) {
                final song = _playlist[index];
                return ListTile(
                  title: Text(song["title"]!),
                  trailing: _currentSong == song["file"] && _isPlaying
                      ? Icon(Icons.pause_circle_filled, color: Colors.blue)
                      : Icon(Icons.play_circle_filled, color: Colors.grey),
                  onTap: () {
                    if (_currentSong == song["file"] && _isPlaying) {
                      _pauseMusic();
                    } else {
                      _playMusic(song["file"]!);
                    }
                  },
                );
              },
            ),
          ),
          if (_currentSong != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Aktueller Titel: ${_playlist.firstWhere((song) => song["file"] == _currentSong)["title"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _stopMusic,
                        child: Text('Stop'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
