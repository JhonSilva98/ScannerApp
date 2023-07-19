import 'package:flutter/material.dart';
import 'package:scanner_app/telaInicial/tela/material.dart';
import 'package:scanner_app/telaFinal/funcao/funcionDigit.dart';
import 'package:scanner_app/telaFinal/funcao/funcionImpressao.dart';
import 'package:scanner_app/telaFinal/funcao/funcionShare.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class WidgetFinal extends StatefulWidget {
  const WidgetFinal({super.key});

  @override
  State<WidgetFinal> createState() => _WidgetFinalState();
}

class _WidgetFinalState extends State<WidgetFinal> {
  String hora() {
    switch (GlobalVariable().myVariable["hora"]!) {
      case >= 5 && <= 12:
        return "Bom dia!";
      case >= 13 && <= 17:
        return "Boa tarde!";
      default:
        return "Boa noite!";
    }
  }

  bool popupicon = false;
  bool popupiconDigit = false;
  DigitarUp digit = DigitarUp();
  ImpressaoUp impres = ImpressaoUp();
  var imageFile;
  String textoDigit = "";
  List<Widget> widgetFim = [];
  BuildContext? dialogContext;
  bool newverificador = false;

  void setStateCallback() {
    setState(() {
      // Atualize o estado ou execute outras ações necessárias
    });
  }

  Widget getWidgetDigit(String text) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Texto digitalizado'),
              content: SelectableText(text),
              actions: [
                IconButton(
                    onPressed: () {
                      shareOnWhatsApp(text);
                    },
                    icon: const Icon(Icons.share_rounded)),
                TextButton(
                  child: const Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF408bfa),
          //border: Border.all(color: Color(0xFF095ba4), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              height: 10,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              height: 10,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 3,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Icon(
                    Icons.text_fields_rounded,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7))),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "${text.length}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dialogContext = context;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF359fe7),
                            Color(0xFFb9b2fb),
                          ])),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Olá, ${hora()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.27,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: GridView.builder(
                  itemCount: widgetFim.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return widgetFim[index];
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          backgroundColor: Colors.blue,
          children: [
            SpeedDialChild(
              child: Icon(Icons.document_scanner_rounded),
              backgroundColor: Color.fromARGB(255, 75, 226, 221),
              label: 'Impressão',
              onTap: () {
                showModalBottomSheet(
                    context: dialogContext!,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200.0,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Tirar foto'),
                              onTap: () async {
                                await impres.getImageCamera(dialogContext!);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text('Escolher foto da galeria'),
                              onTap: () async {
                                await impres.getImageGallery(dialogContext!);
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.abc_outlined),
              backgroundColor: Color.fromARGB(255, 88, 133, 157),
              label: 'Digitalizar',
              onTap: () {
                showModalBottomSheet(
                    context: dialogContext!,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200.0,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Tirar foto'),
                              onTap: () async {
                                Navigator.pop(dialogContext!);
                                await digit.getImageCamera(
                                    dialogContext!, setStateCallback);
                                newverificador = digit.verificador;
                                if (newverificador) {
                                  setState(() {
                                    textoDigit = digit.textoDigit;
                                    widgetFim.add(getWidgetDigit(textoDigit));
                                    newverificador = false;
                                  });
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text('Escolher foto da galeria'),
                              onTap: () async {
                                Navigator.pop(dialogContext!);
                                await digit.getImageGallery(
                                    dialogContext!, setStateCallback);
                                newverificador = digit.verificador;
                                if (newverificador) {
                                  setState(() {
                                    textoDigit = digit.textoDigit;
                                    widgetFim.add(getWidgetDigit(textoDigit));
                                    newverificador = false;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ));
  }
}
