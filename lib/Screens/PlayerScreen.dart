import 'package:anthem_music_player/Screens/widgets/currentSongWidget.dart';
import 'package:anthem_music_player/Screens/widgets/playerButtonSet.dart';
import 'package:anthem_music_player/Screens/widgets/playerNameWidget.dart';
import 'package:anthem_music_player/Screens/widgets/playingWidget.dart';
import 'package:anthem_music_player/Screens/widgets/progressBar.dart';
import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _myAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    _myAnimation =
        CurvedAnimation(curve: Curves.easeInCubic, parent: _controller);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeChanger, AudioPlayer>(
      builder: (context, themeChanger, audioPlayer, child) {
        return Container(
          color: themeChanger.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.09,
                width: MediaQuery.of(context).size.width,
                color: themeChanger.bgColor,
                child: Row(children: [
                  Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: playerName()),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: themeChanger.bgColor,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: themeChanger.textColor,
                    ),
                  )
                ]),
              ),
              GestureDetector(
                onVerticalDragDown: (details) => Navigator.of(context).pop(),
                child: playingPlayer(MediaQuery.of(context).size.height * 0.6,
                    MediaQuery.of(context).size.width),
              ),
              progressBar(context, MediaQuery.of(context).size.height * 0.1,
                  MediaQuery.of(context).size.width),
              playerButtonSet(MediaQuery.of(context).size.height * 0.1,
                  _myAnimation, _controller),
              currentSongWidget(
                  context, MediaQuery.of(context).size.height * 0.11)
            ],
          ),
        );
      },
    );
  }
}
