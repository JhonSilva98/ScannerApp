import 'package:flutter/material.dart';
import 'package:scanner_app/material.dart';
import 'package:scanner_app/widget/final/funcionDigit.dart';
/*import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'
    as rec;*/

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
  var imageFile;
  String textoDigit = "";
  BuildContext? dialogContext;
  void setStateCallback() {
    setState(() {
      // Atualize o estado ou execute outras ações necessárias
    });
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
                itemCount: digit.listWidgetDigit.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  //print("_________ $index");
                  return digit.retornoWidget(index);
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
                            onTap: () {
                              digit.getImageCamera(
                                  dialogContext!, setStateCallback);
                              Navigator.pop(dialogContext!);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text('Escolher foto da galeria'),
                            onTap: () {
                              digit.getImageGallery(
                                  dialogContext!, setStateCallback);
                              Navigator.pop(dialogContext!);
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
