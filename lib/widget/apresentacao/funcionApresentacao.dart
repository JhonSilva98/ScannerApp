import 'package:flutter/material.dart';
import 'package:scanner_app/widget/apresentacao/widgetApresentacao.dart';
import 'package:scanner_app/widget/final/widgetFinal.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> checkFirstSeen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _seen = (prefs.getBool('seen') ?? false);

  if (!_seen) {
    // Navegue para a tela que você deseja mostrar apenas uma vez
    await prefs.setBool('seen', true);
    return MyHomePage();
  } else {
    return WidgetFinal();
  }
}
