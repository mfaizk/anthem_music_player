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
          child: PlayerBuilder.realtimePlayingInfos(
            player: audioPlayer.audioAssetplayer,
            builder: (context, realtimePlayingInfos) {
              RealtimePlayingInfos rInfo = realtimePlayingInfos;
              if (rInfo != null) {
                return Text(
                  "Playing: " +
                      rInfo.current.audio.audio.metas.title.toString(),
                  style: GoogleFonts.roboto(color: themeChanger.textColor),
                );
              }

              return Text(
                'Playing=null',
                style: GoogleFonts.roboto(color: themeChanger.textColor),
              );
            },
          ));
    },
  );
}
