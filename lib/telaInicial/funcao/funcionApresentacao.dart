import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner_app/telaInicial/tela/widgetApresentacao.dart';
import 'package:scanner_app/telaFinal/tela/widgetFinal.dart';

Future<Widget> checkFirstSeen() async {
  PermissionStatus statusCamera = await Permission.camera.status;
  PermissionStatus statusArquivos = await Permission.storage.status;

  if (!statusCamera.isGranted && !statusArquivos.isGranted) {
    // Navegar para a tela que você deseja mostrar apenas uma vez
    return const MyHomePage();
  } else {
    return const WidgetFinal();
  }
}
