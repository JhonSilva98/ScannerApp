import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/firebase/firebase_options.dart';
import 'telaInicial/tela/material.dart';

//https://pub.dev/packages/printing //para impressao

//alterar os pdfs salvos ver no chatgpt o exemplo
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
