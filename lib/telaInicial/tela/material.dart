import 'package:flutter/material.dart';
import 'package:scanner_app/telaInicial/funcao/funcionApresentacao.dart';

class GlobalVariable {
  static final GlobalVariable _instance = GlobalVariable._internal();
  Map<String, double> myVariable = {};
  factory GlobalVariable() {
    return _instance;
  }

  GlobalVariable._internal();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();

    GlobalVariable().myVariable = {
      "hora": currentTime.hour.toDouble(),
      "minuto": currentTime.minute.toDouble(),
      "segundos": currentTime.second.toDouble()
    };
    return MaterialApp(
      title: 'Scanner App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Erro ao carregar o widget');
          } else {
            return snapshot.data ?? Container();
          }
        },
      ),
    );
  }
}
