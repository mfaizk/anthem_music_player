import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AudioPlayer extends ChangeNotifier {
  var currentSongIndex;
  var currentDuration;
  var lastSongPlayed;
  var isPlaying;
  final audioAssetplayer = new AssetsAudioPlayer.withId('0');
  final playListing = AssetsAudioPlayer().playlist;

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
            image: element.album.isEmpty
                ? null
                : MetasImage.file(element.albumArtwork),
          )));
    });
    // print(audioList[0].audioType);

    try {
      await audioAssetplayer.open(
        Playlist(audios: audioList),
        autoStart: false,
        playInBackground: PlayInBackground.enabled,
        showNotification: true,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
        audioFocusStrategy:
            AudioFocusStrategy.request(resumeAfterInterruption: true),
      );
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }

  set playSong(int id) {
    print(id);
    audioAssetplayer.playlistPlayAtIndex(id);
  }
}
