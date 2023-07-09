import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/firebase_options.dart';
import 'material.dart';

//https://pub.dev/packages/printing //para impressao
//api Scanner https://pub.dev/packages/document_scanner_flutter/install

//verificar o widgetapresentacao para solicitar o acesso a galeria que so aparece camera para
//testar e tambem colocar esses dados para so passar para proxima tela se tiver com a camera
//e permitida
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
