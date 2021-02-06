import 'package:anthem_music_player/Screens/HomeScreen.dart';
import 'package:anthem_music_player/functions/AudioPlayer.dart';
import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:anthem_music_player/functions/permissionHandler.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    print(notification.audioId);
    return true;
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeChanger(),
      ),
      ChangeNotifierProvider(
        create: (context) => AudioPlayer(),
      ),
      ChangeNotifierProvider(
        create: (context) => PermissionServiceHandler(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
// ChangeNotifierProvider(
//     create: (context) => ThemeChanger(),
//     child: MyApp(),
//   )
