import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  Color primaryColor = Color(0xff3DBE29);
  Color bodyColor = Color(0xff22CB5C);
  Color buttonColor = Color(0xff242B2E);

  set changeTheme(String colorsString) {
    if (colorsString == "blue") {
      this.primaryColor = Color(0xff2827CC);
      this.bodyColor = Color(0xff3944F7);
      this.buttonColor = Color(0xff03203C);
    } else if (colorsString == "green") {
      this.primaryColor = Color(0xff3DBE29);
      this.bodyColor = Color(0xff22CB5C);
      this.buttonColor = Color(0xff242B2E);
    } else if (colorsString == "purple") {
      this.primaryColor = Color(0xff5A20CB);
      this.bodyColor = Color(0xff8D3DAF);
      this.buttonColor = Color(0xffffffff);
    }
    notifyListeners();
  }
}
