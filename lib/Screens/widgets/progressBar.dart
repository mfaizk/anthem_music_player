import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Widget progressBar(BuildContext context, double height, double width) {
  return Consumer2<AudioPlayer, ThemeChanger>(
    builder: (context, audioPlayer, themeChanger, child) {
      return Material(
        child: Container(
          color: themeChanger.primaryColor,
          height: height,
          width: width,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: height,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: PlayerBuilder.realtimePlayingInfos(
                      player: audioPlayer.audioAssetplayer,
                      builder: (context, realtimePlayingInfos) {
                        RealtimePlayingInfos rInfo = realtimePlayingInfos;
                        if (rInfo == null) {
                          return Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Slider(
                              min: 0,
                              divisions: 1000,
                              max: rInfo.duration.inSeconds.toDouble(),
                              value: rInfo.currentPosition.inSeconds.toDouble(),
                              onChanged: (value) {
                                audioPlayer.audioAssetplayer
                                    .seek(Duration(seconds: value.toInt()));
                              });
                        }
                      },
                    )),

                // Container(
                //   height: height,
                //   width: MediaQuery.of(context).size.width * 0.8,
                //   //TODO: solve stream builder error
                //   child: StreamBuilder(
                //     stream: audioPlayer.audioAssetplayer.currentPosition,
                //     builder: (context, asyncSnapshot) {
                //       final Duration duration = asyncSnapshot.data;
                //       if (asyncSnapshot.data == null) {
                //         return Container(
                //             alignment: Alignment.center,
                //             child: CircularProgressIndicator());
                //       } else if (asyncSnapshot.connectionState ==
                //           ConnectionState.waiting) {
                //         return Container(
                //             alignment: Alignment.center,
                //             child: CircularProgressIndicator());
                //       } else if (asyncSnapshot.connectionState ==
                //           ConnectionState.active) {
                //         return StreamBuilder(
                //           stream:
                //               audioPlayer.audioAssetplayer.realtimePlayingInfos,
                //           builder: (context,
                //               AsyncSnapshot<RealtimePlayingInfos>
                //                   realtimeInfo) {
                //             if (realtimeInfo.data == null) {
                //               return Container(
                //                   alignment: Alignment.center,
                //                   child: CircularProgressIndicator());
                //             } else if (realtimeInfo.connectionState ==
                //                     ConnectionState.waiting &&
                //                 realtimeInfo.data == null) {
                //               return Container(
                //                   alignment: Alignment.center,
                //                   child: CircularProgressIndicator());
                //             } else if (realtimeInfo.connectionState ==
                //                 ConnectionState.active) {
                //               return SliderTheme(
                //                   data: SliderTheme.of(context).copyWith(
                //                     activeTrackColor: Colors.red[700],
                //                     inactiveTrackColor: Colors.red[100],
                //                     trackShape: RoundedRectSliderTrackShape(),
                //                     trackHeight: 4.0,
                //                     thumbShape: RoundSliderThumbShape(
                //                         enabledThumbRadius: 12.0),
                //                     thumbColor: Colors.redAccent,
                //                     overlayColor: Colors.red.withAlpha(32),
                //                     overlayShape: RoundSliderOverlayShape(
                //                         overlayRadius: 28.0),
                //                     tickMarkShape: RoundSliderTickMarkShape(),
                //                     activeTickMarkColor: Colors.red[700],
                //                     inactiveTickMarkColor: Colors.red[100],
                //                     valueIndicatorShape:
                //                         PaddleSliderValueIndicatorShape(),
                //                     valueIndicatorColor: Colors.redAccent,
                //                   ),
                //                   child: Slider(
                //                     min: 0.0,
                //                     divisions: 10000,
                //                     max: realtimeInfo.data.duration.inSeconds !=
                //                             null
                //                         ? realtimeInfo.data.duration.inSeconds
                //                             .toDouble()
                //                         : 0,
                //                     activeColor: themeChanger.bgColor,
                //                     value: realtimeInfo.data.currentPosition
                //                                 .inSeconds !=
                //                             null
                //                         ? realtimeInfo
                //                             .data.currentPosition.inSeconds
                //                             .toDouble()
                //                         : 0,
                //                     onChanged: (value) {
                //                       audioPlayer.audioAssetplayer.seek(
                //                           Duration(seconds: value.toInt()));
                //                     },
                //                   ));
                //             } else {
                //               return CircularProgressIndicator();
                //             }
                //           },
                //         );
                //       } else {
                //         return Container(child: CircularProgressIndicator());
                //       }
                //     },
                //   ),
                // ),
                Container(
                    alignment: Alignment.center,
                    height: height,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: AudioPlayer()
                        .audioAssetplayer
                        .builderRealtimePlayingInfos(
                      builder: (context, realtimePlayingInfos) {
                        RealtimePlayingInfos rInfo = realtimePlayingInfos;
                        if (rInfo == null) {
                          return Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Text(
                              rInfo.currentPosition.toString().substring(2, 7),
                              style: GoogleFonts.openSans(
                                  color: themeChanger.textColor));
                        }
                      },
                    )
                    //StreamBuilder(
                    //     stream: audioPlayer.audioAssetplayer.currentPosition,
                    //     builder: (context, asyncSnapshot) {
                    //       final Duration duration = asyncSnapshot.data;
                    //       return duration.inSeconds != null
                    //           ? Text(duration.inSeconds.toString())
                    //           : Text(":_ _");
                    //     }),
                    )
              ]),
        ),
      );
    },
  );
}
//  Text(duration.inSeconds.toString())

// snapshot1.data.inSeconds.toDouble(),
