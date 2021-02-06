import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Widget currentSongWidget(BuildContext context, double height) {
  return Consumer2<ThemeChanger, AudioPlayer>(
    builder: (context, themeChanger, audioPlayer, child) {
      return Material(
        color: themeChanger.primaryColor,
        child: StreamBuilder(
          stream: audioPlayer.audioAssetplayer.realtimePlayingInfos,
          builder: (context, AsyncSnapshot<RealtimePlayingInfos> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.active) {
              return Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: height,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    "Playing: " + snapshot.data.current.audio.audio.metas.title,
                    style: GoogleFonts.openSans(
                        color: themeChanger.textColor,
                        fontSize: MediaQuery.of(context).size.height * 0.025),
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      );
    },
  );
}
