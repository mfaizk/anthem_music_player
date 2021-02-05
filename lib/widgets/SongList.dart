import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:anthem_music_player/widgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

Widget songlistWidget(BuildContext context) {
  return Consumer<ThemeChanger>(builder: (context, value, child) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: FlutterAudioQuery().getSongs(),
          builder: (context, snapshot) {
            List<SongInfo> songInfo = snapshot.data;
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: songInfo.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      tileColor: value.listColor,
                      onTap: () {
                        AudioPlayer().playSong = index;
                      },
                      leading: Text(
                        songInfo[index].displayName,
                        style: TextStyle(color: value.textColor),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingAnimatedScreen(context);
            } else {
              return Text(snapshot.error);
            }
          }),
    );
  });
}
