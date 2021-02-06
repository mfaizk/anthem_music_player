import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

Widget loadingAnimatedScreen(BuildContext context) {
  return Consumer<ThemeChanger>(
    builder: (context, value, child) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: value.bodyColor,
        child: Lottie.asset(
          'assets/loading.json',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 4,
        ),
        alignment: Alignment.center,
      );
    },
  );
}
