import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/firebase/firebase_options.dart';
import 'telaFinal/funcao/funcionImpressao.dart';
import 'telaInicial/tela/material.dart';

//https://pub.dev/packages/printing //para impressao

//fiz a funcao funcionExitAppDelete verificar e testar para ver se quando fechar apaga
ImpressaoUp impresMainDelete = ImpressaoUp();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  await impresMainDelete.deleteArquivos();
}
