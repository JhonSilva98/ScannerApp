import 'package:flutter/material.dart';
import 'package:scanner_app/material.dart';
import 'package:scanner_app/widget/final/funcionDigit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetFinal extends StatefulWidget {
  const WidgetFinal({super.key});

  @override
  State<WidgetFinal> createState() => _WidgetFinalState();
}

class _WidgetFinalState extends State<WidgetFinal> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
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
  var imageFile;
  String textoDigit = "";
  List<Widget> widgetFim = [];
  //List<String> textguardDigit = [];
  BuildContext? dialogContext;

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
              title: Text('Texto digitalizado'),
              content: SelectableText('$text'),
              actions: [
                TextButton(
                  child: Text('Fechar'),
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
          color: Color(0xFF408bfa),
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
                Expanded(
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
                    child: Text(
                      "${GlobalVariable().myVariable["segundos"]!}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.all(12),
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
                padding: EdgeInsets.only(left: 20),
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
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
                    style: TextStyle(
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
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: GridView.builder(
                itemCount: widgetFim.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /*if (popupicon == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "Scanear",
                  tooltip: "Scanear",
                  mini: true,
                  onPressed: () {},
                  child: Icon(Icons.document_scanner),
                ),
                FloatingActionButton(
                  heroTag: "Digitalizar",
                  tooltip: "Digitalizar",
                  mini: true,
                  onPressed: () {
                    setState(() {
                      popupicon = false;
                      popupiconDigit = true;
                    });
                  },
                  child: Icon(Icons.abc),
                )
              ],
            ),
          if (popupiconDigit == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "Camera",
                  tooltip: "Camera",
                  mini: true,
                  onPressed: () {
                    if (popupiconDigit == true) {
                      getImageCamera();
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(Icons.camera_alt_rounded),
                ),
                FloatingActionButton(
                  heroTag: "Galeria",
                  tooltip: "Galeria",
                  mini: true,
                  onPressed: () {
                      getImageGallery();
                      Navigator.pop(context);
                  },
                  child: Icon(Icons.photo),
                )
              ],
            ),*/
          Padding(padding: EdgeInsets.only(top: 20)),
          FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: dialogContext!,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200.0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Tirar foto'),
                            onTap: () async {
                              Navigator.pop(dialogContext!);
                              await digit.getImageCamera(
                                  dialogContext!, setStateCallback);
                              setState(() {
                                textoDigit = digit.textoDigit;
                                widgetFim.add(getWidgetDigit(textoDigit));
                              });
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text('Escolher foto da galeria'),
                            onTap: () async {
                              Navigator.pop(dialogContext!);
                              await digit.getImageGallery(
                                  dialogContext!, setStateCallback);
                              setState(() {
                                textoDigit = digit.textoDigit;
                                widgetFim.add(getWidgetDigit(textoDigit));
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
