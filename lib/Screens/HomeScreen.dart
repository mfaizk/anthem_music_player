import 'package:anthem_music_player/Screens/widgets/SongList.dart';
import 'package:anthem_music_player/Screens/widgets/loadingPage.dart';
import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:anthem_music_player/functions/permissionHandler.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/widgets/fab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = 'One';
  bool isMenuEnable = false;
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Consumer3<ThemeChanger, AudioPlayer, PermissionServiceHandler>(
          builder: (context, themeChanger, audioPlayer, perm, child) {
        return FutureBuilder<bool>(
            future: perm.permissionRequester,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return Scaffold(
                    floatingActionButton: fab(),
                    appBar: AppBar(
                      actions: [
                        MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              // themePersistantValueWriter("blue");
                              MoveToBackground.moveTaskToBack();
                            }),
                        MaterialButton(
                            color: Colors.purple,
                            onPressed: () {
                              themePersistantValueWriter("purple");
                            }),
                        Container(
                          decoration: BoxDecoration(
                              color: themeChanger.primaryColor,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1)),
                          width: MediaQuery.of(context).size.width * 0.15,
                          alignment: Alignment.bottomRight,
                          height: 0,
                          child: GestureDetector(
                              onTap: () {},
                              child: DropdownButton<String>(
                                // value: dropdownValue,

                                // onTap: () {
                                //   if (dropdownValue.toString() == 'One') {
                                //     print('one');
                                //   }
                                // },
                                icon: Icon(
                                  EvaIcons.moreVertical,
                                  color: themeChanger.textColor,
                                ),
                                style: TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String newValue) {
                                  // setState(() {
                                  //   dropdownValue = newValue;
                                  // });
                                  // onTap: () {
                                  if (newValue.toString() == 'One') {
                                    print('one');
                                  }
                                },
                                items: <String>[
                                  'One',
                                  'Two',
                                  'Free',
                                  'Four'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                        ),
                      ],
                      backgroundColor: themeChanger.primaryColor,
                    ),
                    body: songlistWidget(context));
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: loadingAnimatedScreen(context),
              );
            });
      }),
    );
  }
}
