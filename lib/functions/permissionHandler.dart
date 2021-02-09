import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionServiceHandler extends ChangeNotifier {
  var result;
  var isGranted;
  Future<bool> get permissionRequester async {
    var result = await Permission.storage.request();

    if (result == PermissionStatus.granted) {
      this.isGranted = true;
    } else {
      this.isGranted = false;
    }
    notifyListeners();
    return isGranted;
  }
}
