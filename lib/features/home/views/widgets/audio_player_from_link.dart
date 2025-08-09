import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioPlayerFromLink extends StatefulWidget {
  final String url;
  const AudioPlayerFromLink({super.key, required this.url});

  @override
  State<AudioPlayerFromLink> createState() => _AudioPlayerFromLinkState();
}

class _AudioPlayerFromLinkState extends State<AudioPlayerFromLink> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.openPlayer();
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _player.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _player.startPlayer(
        fromURI: widget.url,
        codec: Codec.mp3, // Use correct codec for your URL
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _togglePlay,
      icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
      label: Text(_isPlaying ? 'إيقاف' : 'تشغيل الصوت المصحح'),
    );
  }
}
