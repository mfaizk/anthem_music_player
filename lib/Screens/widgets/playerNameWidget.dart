import 'package:anthem_music_player/functions/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Widget playerName() {
  return Consumer<ThemeChanger>(builder: (context, themeChanger, child) {
    return FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.contain,
        child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: 'An',
              style: GoogleFonts.aBeeZee(),
            ),
            TextSpan(
                text: 'th',
                style: TextStyle(
                  color: themeChanger.bodyColor,
                )),
            TextSpan(
              text: 'em',
              style: GoogleFonts.aBeeZee(),
            ),
            TextSpan(
              text: 'Music',
              style: GoogleFonts.aBeeZee(),
            ),
            TextSpan(
                text: 'P', style: TextStyle(color: themeChanger.bodyColor)),
            TextSpan(
              text: 'layer',
              style: GoogleFonts.aBeeZee(),
            )
          ]),
        ));
  });
}
