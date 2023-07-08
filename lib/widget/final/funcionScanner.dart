import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'
    as rec;

class DigitarUp {
  var imageFile;
  String textoDigit = "";

  void getImageGallery(BuildContext context) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        cropImage(pickedImage, context);
      }
    } catch (e) {
      imageFile = null;
    }
  }

  void getImageCamera(BuildContext context) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        cropImage(pickedImage, context);
        //getRecognisedText(rec.InputImage.fromFilePath(pickedImage.toString()));
      }
    } catch (e) {
      imageFile = null;
    }
  }

  void getRecognisedText(rec.InputImage image) async {
    final textRecognizer =
        rec.TextRecognizer(script: rec.TextRecognitionScript.latin);
    final rec.RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    textoDigit = recognizedText.text;
  }

  void cropImage(XFile picked, BuildContext context) async {
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
    }
  }
}
