import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  Color primaryColor = Color(0xff2827CC);
  Color bodyColor = Color(0xff3944F7);
  Color buttonColor = Color(0xff2827CC);
  Color listColor = Color(0xff120E43);
  Color textColor = Color(0xffCAD5E2);
  Color bgColor = Color(0xff0D0D0D);
  set changeTheme(String colorsString) {
    if (colorsString == "blue") {
      this.primaryColor = Color(0xff2827CC);
      this.bodyColor = Color(0xff3944F7);
      this.buttonColor = Color(0xff2827CC);
      this.listColor = Color(0xff383CC1);
      this.textColor = Color(0xffCAD5E2);
      this.bgColor = Color(0xff0D0D0D);
    } else if (colorsString == "purple") {
      this.primaryColor = Color(0xff5A20CB);
      this.bodyColor = Color(0xff8D3DAF);
      this.buttonColor = Color(0xff5A20CB);
      this.listColor = Color(0xff5A20CB);
      this.textColor = Color(0xffCAD5E2);
      this.bgColor = Color(0xff0D0D0D);
    }
    notifyListeners();
  }
}
