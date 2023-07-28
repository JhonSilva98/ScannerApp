import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scanner_app/telaFinal/funcao/funcionImpress.dart';
import 'package:scanner_app/telaInicial/tela/material.dart';
import 'package:scanner_app/telaFinal/funcao/funcionDigit.dart';
import 'package:scanner_app/telaFinal/funcao/funcionShare.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

class WidgetFinal extends StatefulWidget {
  const WidgetFinal({super.key});

  @override
  State<WidgetFinal> createState() => _WidgetFinalState();
}

class _WidgetFinalState extends State<WidgetFinal> {
  funcionImpressUP impres = funcionImpressUP();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //impres.delListPDF();
  }

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

  DigitarUp digit = DigitarUp();

  var imageFile;
  String textoDigit = "";
  List<Widget> widgetFim = [];
  BuildContext? dialogContext;
  bool newverificador = false;
  List<String> imagesPath = [];
  XFile? listPdf;
  String namePDF = "";
  String caminhoPDF = "";
  int? pos;
  List<String> caminhoPDFDelete = [];

  void setStateCallback() {
    setState(() {});
  }

  Widget getWidget(String text, String icone, bool funcion,
      {String? namePDF, int? index}) {
    return GestureDetector(
      onTap: () {
        if (funcion) {
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
        } else {
          OpenFile.open(text);
        }
      },
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                icone,
                height: 100,
                width: 100,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "${funcion ? text.length : namePDF}",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
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
                    pos = index;
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
                                Navigator.pop(dialogContext!);
                                await impres.pickImages(
                                    dialogContext!, setStateCallback);
                                newverificador = impres.newverificador;
                                imagesPath = impres.imagesPath;
                                namePDF = impres.namePDF;
                                caminhoPDFDelete = impres.caminhoPDFDelete;
                                textoDigit = impres.textoDigit;
                                listPdf = impres.listPdf;
                                if (newverificador) {
                                  setState(() {
                                    widgetFim.add(getWidget(
                                        textoDigit, "assets/pdf.png", false,
                                        namePDF: namePDF, index: pos));
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
                                await impres.pickImages(
                                    dialogContext!, setStateCallback);

                                if (newverificador) {
                                  setState(() {
                                    widgetFim.add(getWidget(
                                        textoDigit, "assets/pdf.png", false,
                                        namePDF: namePDF, index: pos));
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
                                    widgetFim.add(getWidget(
                                        textoDigit, "assets/txt.png", true,
                                        index: pos));
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
                                    widgetFim.add(getWidget(
                                        textoDigit, "assets/txt.png", true,
                                        index: pos));
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
