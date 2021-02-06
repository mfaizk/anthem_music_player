import 'package:anthem_music_player/Screens/widgets/loadingPage.dart';
import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
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
                        subtitle: Text(
                          songInfo[index].artist,
                          style: GoogleFonts.roboto(color: value.textColor),
                        ),
                        tileColor: value.listColor,
                        onTap: () {
                          AudioPlayer().playSong = index;
                        },
                        title: Text(songInfo[index].displayName,
                            style:
                                GoogleFonts.openSans(color: value.textColor)),
                        leading: Container(
                          decoration: new BoxDecoration(
                            color: value.bodyColor,
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.01,
                            ),
                          ),
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02),
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Icon(Icons.music_note),
                        )),
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
