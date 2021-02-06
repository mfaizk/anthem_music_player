import 'package:anthem_music_player/Screens/widgets/SongList.dart';
import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/widgets/fab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  themePersistantValueWriter(String colorString) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("color", colorString);
    ThemeChanger themeChanger =
        Provider.of<ThemeChanger>(context, listen: false);
    themeChanger.changeTheme = colorString;
  }

  themeProvider() async {
    ThemeChanger themeChanger =
        Provider.of<ThemeChanger>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final colorString = pref.get("color");
    if (colorString.toString().isEmpty) {
      themeChanger.changeTheme = "blue";
    } else {
      themeChanger.changeTheme = colorString;
    }
  }

  @override
  void initState() {
    super.initState();
    themeProvider();
    AudioPlayer().loadSongs();
    AudioPlayer().audioPlayerListner();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeChanger, AudioPlayer>(
        builder: (context, themeChanger, audioPlayer, child) {
      return Scaffold(
          floatingActionButton: fab(),
          appBar: AppBar(
            actions: [
              MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    themePersistantValueWriter("blue");
                  }),
              MaterialButton(
                  color: Colors.purple,
                  onPressed: () {
                    themePersistantValueWriter("purple");
                  })
            ],
            backgroundColor: themeChanger.primaryColor,
          ),
          body: songlistWidget(context));
    });
  }
}
