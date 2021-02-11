import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AudioPlayer extends ChangeNotifier {
  var currentSongIndex;
  var currentDuration;
  var lastSongPlayed;
  var isPlaying;
  final audioAssetplayer = new AssetsAudioPlayer.withId('0');
  List<SongInfo> songInfo;
  List<Audio> audioList = new List<Audio>();

  var isLoaded;

  Future<bool> loadSongs() async {
    FlutterAudioQuery query = new FlutterAudioQuery();
    this.songInfo = await query.getSongs();

    songInfo.forEach((element) {
      this.audioList.add(Audio.file(element.filePath,
          metas: Metas(
            title: element.title.isEmpty ? "Title Not Found" : element.title,
            artist:
                element.artist.isEmpty ? "Artist Not Found" : element.artist,
            album:
                element.album.isEmpty ? "Album Name Not Found" : element.album,
            image: element.album.isEmpty
                ? null
                : MetasImage.file(element.albumArtwork),
          )));
    });

    try {
      await audioAssetplayer
          .open(
        Playlist(audios: this.audioList),
        autoStart: false,
        loopMode: LoopMode.playlist,
        playInBackground: PlayInBackground.enabled,
        showNotification: true,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
        audioFocusStrategy:
            AudioFocusStrategy.request(resumeAfterInterruption: true),
      )
          .whenComplete(() {
        this.isLoaded = true;
      });
    } on Exception catch (e) {
      this.isLoaded = false;
    }

    this.isLoaded = false;

    notifyListeners();
  }

  set playSong(int id) {
    print(id);
    audioAssetplayer.playlistPlayAtIndex(id);
  }
}
