import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AudioPlayer extends ChangeNotifier {
  var currentSongIndex;
  var currentDuration;
  var lastSongPlayed;
  var isPlaying = false;
  final audioAssetplayer = new AssetsAudioPlayer.withId('0');
  final playListing = AssetsAudioPlayer().playlist;

  audioPlayerListner() {
    final List<StreamSubscription> _sub = [];

    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print("finished : $data");
    //}));
    _sub.add(audioAssetplayer.playlistAudioFinished.listen((data) {
      print("playlistAudioFinished : $data");
    }));
    _sub.add(audioAssetplayer.audioSessionId.listen((sessionId) {
      print("audioSessionId : $sessionId");
    }));
    //_subscriptions.add(_assetsAudioPlayer.current.listen((data) {
    //  print("current : $data");
    //}));
    //_subscriptions.add(_assetsAudioPlayer.onReadyToPlay.listen((audio) {
    //  print("onReadyToPlay : $audio");
    //}));
    //_subscriptions.add(_assetsAudioPlayer.isBuffering.listen((isBuffering) {
    //  print("isBuffering : $isBuffering");
    //}));
    //_subscriptions.add(_assetsAudioPlayer.playerState.listen((playerState) {
    //  print("playerState : $playerState");
    //}));
    _sub.add(audioAssetplayer.isPlaying.listen((isplaying) {
      this.isPlaying = isplaying;
    }));
    _sub.add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));
    notifyListeners();
  }

  loadSongs() async {
    FlutterAudioQuery query = new FlutterAudioQuery();

    List<SongInfo> songInfo = await query.getSongs();
    List<Audio> audioList = new List<Audio>();

    songInfo.forEach((element) {
      audioList.add(Audio.file(element.filePath,
          metas: Metas(
            title: element.title.isEmpty ? "Title Not Found" : element.title,
            artist:
                element.artist.isEmpty ? "Artist Not Found" : element.artist,
            album:
                element.album.isEmpty ? "Album Name Not Found" : element.album,
          )));
    });
    // print(audioList[0].audioType);

    try {
      await audioAssetplayer.open(
        Playlist(audios: audioList),
        autoStart: false,
        showNotification: true,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
        audioFocusStrategy:
            AudioFocusStrategy.request(resumeAfterInterruption: true),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  set playSong(int id) {
    print(id);
    audioAssetplayer.playlistPlayAtIndex(id);
  }
}
