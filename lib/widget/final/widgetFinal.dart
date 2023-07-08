import 'package:flutter/material.dart';
import 'package:scanner_app/material.dart';
import 'package:scanner_app/widget/final/funcionScanner.dart';
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
                      fontSize: 50.0,
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
                              digit.getImageCamera(dialogContext!);
                              Navigator.pop(dialogContext!);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text('Escolher foto da galeria'),
                            onTap: () {
                              digit.getImageGallery(dialogContext!);
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

  /*void getImageGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        cropImage(pickedImage);
      }
    } catch (e) {
      imageFile = null;
    }
  }

  void getImageCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        cropImage(pickedImage);
      }
    } catch (e) {
      imageFile = null;
    }
  }

  void getRecognisedText(rec.InputImage image) async {
    // Verifica se o State ainda está ativo

    final textRecognizer =
        rec.TextRecognizer(script: rec.TextRecognitionScript.latin);
    final rec.RecognizedText recognizedText =
        await textRecognizer.processImage(image);
// Verifica novamente se o State ainda está ativo
    setState(() {
      textoDigit = recognizedText.text;
      print(textoDigit);
    });
  }

  Future<void> cropImage(XFile picked) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: picked.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort:
              const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        XFile xFile = XFile(croppedFile.path);
        imageFile = rec.InputImage.fromFilePath(xFile.path);
        getRecognisedText(imageFile);
        showDialog(
          context: context,
          barrierDismissible:
              false, // Impede o fechamento do popup ao tocar fora dele
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  Text('Carregando...'),
                ],
              ),
            );
          },
        );
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context); // Fecha o popup após 5 segundos
        });
      });
    }
  }*/
}

/*Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF359fe7),
                    Color(0xFFb9b2fb),
                  ])),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt),
      ),
    );*/