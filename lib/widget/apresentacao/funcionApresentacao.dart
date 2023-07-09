import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner_app/widget/apresentacao/widgetApresentacao.dart';
import 'package:scanner_app/widget/final/widgetFinal.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> checkFirstSeen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _seen = (prefs.getBool('seen') ?? false);
  PermissionStatus statusCamera = await Permission.camera.status;

  if (!_seen && !statusCamera.isGranted) {
    // Navegar para a tela que você deseja mostrar apenas uma vez
    await prefs.setBool('seen', true);
    return MyHomePage();
  } else {
    return WidgetFinal();
  }
}
