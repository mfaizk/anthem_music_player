import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AudioFetcher extends ChangeNotifier {
  List<SongInfo> songInfo;

  Future<List<SongInfo>> fetch() async {
    await FlutterAudioQuery().getSongs().then((value) {
      this.songInfo = value;
    });
    notifyListeners();
    return this.songInfo;
  }
}
