import 'dart:ffi';

import 'package:anthem_music_player/Screens/widgets/loadingPage.dart';
import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

Widget playingPlayer(double height, double width) {
  return Consumer2<ThemeChanger, AudioPlayer>(
    builder: (context, themeChanger, audioPlayer, child) {
      return Container(
          height: height,
          width: width,
          color: themeChanger.bgColor,
          alignment: Alignment.center,
          child: StreamBuilder<bool>(
            stream: audioPlayer.audioAssetplayer.isPlaying,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingAnimatedScreen(context);
              } else {
                return Lottie.asset('assets/music.json',
                    animate: snapshot.data);
              }
            },
          ));
    },
  );
}
