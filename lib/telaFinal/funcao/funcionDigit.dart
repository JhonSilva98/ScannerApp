import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'
    as rec;

class DigitarUp {
  var imageFile;
  String textoDigit = "";
  bool verificador = false;

  Future<void> getImageGallery(
      BuildContext context, Function setStateCallback) async {
    verificador = false;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        await cropImage(pickedImage, context, setStateCallback);
      }
    } catch (e) {
      imageFile = null;
    }
  }

  Future<void> getImageCamera(
      BuildContext context, Function setStateCallback) async {
    verificador = false;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        await cropImage(pickedImage, context, setStateCallback);
      }
    } catch (e) {
      imageFile = null;
    }
  }

  Future<void> getRecognisedText(rec.InputImage image, BuildContext context,
      Function setStateCallback) async {
    final textRecognizer =
        rec.TextRecognizer(script: rec.TextRecognitionScript.latin);
    final rec.RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    textoDigit = recognizedText.text;
    verificador = true;
    setStateCallback();
  }

  Future<void> cropImage(
      XFile picked, BuildContext context, Function setStateCallback) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: picked.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cortar',
            toolbarColor: Colors.blueAccent,
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
      verificador = true;
      XFile xFile = XFile(croppedFile.path);
      imageFile = rec.InputImage.fromFilePath(xFile.path);
      showDialog(
        context: context,
        barrierDismissible:
            false, // Impede o fechamento do popup ao tocar fora dele
        builder: (BuildContext context) {
          return const AlertDialog(
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
      await getRecognisedText(imageFile, context, setStateCallback);
      Navigator.pop(context);

      /*Future.delayed(Duration(seconds: 5), () {
        Navigator.pop(context); // Fecha o popup após 5 segundos
      });*/
    }
  }
}
