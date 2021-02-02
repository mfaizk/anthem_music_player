import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    themePersistantValueWriter("blue");
                  }),
              MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    themePersistantValueWriter("green");
                  })
            ],
            backgroundColor: value.primaryColor,
          ),
          body: Container(
            color: value.bodyColor,
          ),
        );
      },
    );
  }
}
