import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/firebase_options.dart';
import 'material.dart';

//https://pub.dev/packages/printing //para impressao
//api Scanner https://pub.dev/packages/document_scanner_flutter/install

//testar o uso de callback do setstate void ja criada no widgetfinal ver chatgpt

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
