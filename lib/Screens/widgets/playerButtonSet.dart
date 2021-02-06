import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget playerButtonSet(double height, CurvedAnimation _myAnimation,
    AnimationController _controller) {
  return Consumer2<ThemeChanger, AudioPlayer>(
    builder: (context, themeChanger, audioPlayer, child) {
      return Container(
        color: themeChanger.bgColor,
        width: MediaQuery.of(context).size.width,
        height: height,
        child: StreamBuilder(
          stream: audioPlayer.audioAssetplayer.isPlaying,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: GestureDetector(
                    child: Icon(
                      EvaIcons.skipBack,
                      color: themeChanger.buttonColor,
                      size: MediaQuery.of(context).size.width * 0.14,
                    ),
                    onTap: () => audioPlayer.audioAssetplayer.previous(),
                  ),
                ),
                Container(
                  height: height,
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.center,
                  child: GestureDetector(
                      child: AnimatedIcon(
                        icon: AnimatedIcons.pause_play,
                        progress: _myAnimation,
                        size: MediaQuery.of(context).size.width * 0.2,
                        color: themeChanger.buttonColor,
                      ),
                      onTap: () {
                        if (snapshot.data == true) {
                          audioPlayer.audioAssetplayer.playOrPause();
                          _controller.forward();
                        } else if (snapshot.data == false) {
                          audioPlayer.audioAssetplayer.playOrPause();
                          _controller.reverse();
                        } else {
                          print("yo");
                        }
                      }),
                ),
                Container(
                  height: height,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: GestureDetector(
                    child: Icon(
                      EvaIcons.skipForward,
                      color: themeChanger.buttonColor,
                      size: MediaQuery.of(context).size.width * 0.14,
                    ),
                    onTap: () => audioPlayer.audioAssetplayer.next(),
                  ),
                )
              ],
            );
          },
        ),
      );
    },
  );
}
