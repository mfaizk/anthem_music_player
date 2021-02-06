import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget progressBar(double height, double width) {
  return Consumer2<AudioPlayer, ThemeChanger>(
    builder: (context, audioPlayer, themeChanger, child) {
      return Material(
        child: Container(
          height: height,
          width: width,
          child: Row(children: [
            Container(
              height: height,
              width: MediaQuery.of(context).size.width * 0.9,
              child: StreamBuilder<Duration>(
                stream: audioPlayer.audioAssetplayer.currentPosition,
                builder: (context, AsyncSnapshot<Duration> snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot1.connectionState ==
                      ConnectionState.active) {
                    return StreamBuilder(
                      stream: audioPlayer.audioAssetplayer.realtimePlayingInfos,
                      builder: (context,
                          AsyncSnapshot<RealtimePlayingInfos> realtimeInfo) {
                        if (realtimeInfo.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (realtimeInfo.connectionState ==
                            ConnectionState.active) {
                          return SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.red[700],
                                inactiveTrackColor: Colors.red[100],
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 4.0,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                thumbColor: Colors.redAccent,
                                overlayColor: Colors.red.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                                tickMarkShape: RoundSliderTickMarkShape(),
                                activeTickMarkColor: Colors.red[700],
                                inactiveTickMarkColor: Colors.red[100],
                                valueIndicatorShape:
                                    PaddleSliderValueIndicatorShape(),
                                valueIndicatorColor: Colors.redAccent,
                              ),
                              child: Slider(
                                min: 0.0,
                                divisions: 10000,
                                max: realtimeInfo.data.duration.inSeconds
                                    .toDouble(),
                                activeColor: themeChanger.bgColor,
                                value: snapshot1.data.inSeconds.toDouble(),
                                onChanged: (value) {
                                  audioPlayer.audioAssetplayer
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ));
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: height,
              width: MediaQuery.of(context).size.width * 0.1,
              child: StreamBuilder(
                  stream: audioPlayer.audioAssetplayer.currentPosition,
                  builder: (context, asyncSnapshot) {
                    final Duration duration = asyncSnapshot.data;
                    return Text(duration.inSeconds.toString());
                  }),
            )
          ]),
        ),
      );
    },
  );
}