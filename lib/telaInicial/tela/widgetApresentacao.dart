import 'package:flutter/material.dart';
import 'package:scanner_app/telaFinal/tela/widgetFinal.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFF359fe7),
              Color(0xFFb9b2fb),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                child: Image.asset("assets/foto.png"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: Text(
                  "Digitalizando e scaneando de maneira simples, fácil e rápido.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(10),
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: () async {
                  PermissionStatus statusCamera =
                      await Permission.camera.status;
                  PermissionStatus statusArquivos =
                      await Permission.storage.status;

                  if (statusCamera.isDenied | !statusCamera.isGranted) {
                    // Caso não tenha permissão para a câmera, solicita a permissão
                    statusCamera = await Permission.camera.request();
                  }

                  if (statusArquivos.isDenied | !statusArquivos.isGranted) {
                    // Caso não tenha permissão para a câmera, solicita a permissão
                    statusArquivos = await Permission.storage.request();
                  }

                  if (statusCamera.isGranted && statusArquivos.isGranted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WidgetFinal()));
                  } else {
                    statusCamera = await Permission.camera.request();
                    statusArquivos = await Permission.storage.request();
                  }
                },
                child: const Text(
                  "Começar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
