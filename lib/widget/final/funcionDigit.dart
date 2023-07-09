import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'
    as rec;
import 'package:scanner_app/material.dart';

class DigitarUp {
  var imageFile;
  String textoDigit = "";
  List<Widget> listWidgetDigit = [];

  Widget retornoWidget(int index) {
    return listWidgetDigit[index];
  }

  void addListWidgetDigit(context) {
    listWidgetDigit.add(getWidgetDigit(context));
  }

  Widget getWidgetDigit(context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Texto digitalizado'),
              content: Text('$textoDigit'),
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
      child: Column(
        children: [
          Container(
            child: Icon(Icons.text_fields_rounded,
                size: 24, color: Color(0xFF095ba4)),
            padding: const EdgeInsets.all(12),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Text("Txt ${GlobalVariable().myVariable["segundos"]!}"),
            padding: const EdgeInsets.all(12),
          )
        ],
      ),
    );
  }

  void getImageGallery(BuildContext context, Function setStateCallback) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        cropImage(pickedImage, context, setStateCallback);
      }
    } catch (e) {
      imageFile = null;
    }
  }

  void getImageCamera(BuildContext context, Function setStateCallback) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        cropImage(pickedImage, context, setStateCallback);
      }
    } catch (e) {
      imageFile = null;
    }
  }

  void getRecognisedText(rec.InputImage image, BuildContext context,
      Function setStateCallback) async {
    final textRecognizer =
        rec.TextRecognizer(script: rec.TextRecognitionScript.latin);
    final rec.RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    textoDigit = recognizedText.text;
    getWidgetDigit(context);
    addListWidgetDigit(context);
    setStateCallback();
  }

  void cropImage(
      XFile picked, BuildContext context, Function setStateCallback) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: picked.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cortar',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cortar',
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
      XFile xFile = XFile(croppedFile.path);
      imageFile = rec.InputImage.fromFilePath(xFile.path);
      getRecognisedText(imageFile, context, setStateCallback);
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
      Future.delayed(Duration(seconds: 8), () {
        Navigator.pop(context); // Fecha o popup após 5 segundos
      });
    }
  }
}
