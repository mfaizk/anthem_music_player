import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:anthem_music_player/widgets/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeChanger(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
// ChangeNotifierProvider(
//     create: (context) => ThemeChanger(),
//     child: MyApp(),
//   )
