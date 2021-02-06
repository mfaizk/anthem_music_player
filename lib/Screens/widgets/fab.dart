import 'package:anthem_music_player/Routes/routes.dart';
import 'package:anthem_music_player/Screens/widgets/loadingPage.dart';
import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget fab() {
  return Consumer2<ThemeChanger, AudioPlayer>(
      builder: (context, themeChanger, audioPlayer, child) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        Navigator.of(context).push(createRoute());
      },
      child: FloatingActionButton(
          onPressed: () {
            AudioPlayer().audioAssetplayer.playOrPause();
          },
          backgroundColor: themeChanger.buttonColor,
          child: StreamBuilder(
            stream: audioPlayer.audioAssetplayer.isPlaying,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingAnimatedScreen(context);
              } else if (snapshot.connectionState == ConnectionState.active) {
                return FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    child: snapshot.data
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow));
              } else {
                return loadingAnimatedScreen(context);
              }
            },
          )),
    );
  });
}
