import 'package:flutter/material.dart';
import 'package:scanner_app/widget/final/widgetFinal.dart';

//api Scanner https://pub.dev/packages/document_scanner_flutter/install

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
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
            Padding(
              padding: const EdgeInsets.all(32.0),
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
                style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(10),
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WidgetFinal()));
                },
                child: Text(
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
