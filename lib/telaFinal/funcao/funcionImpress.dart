import 'dart:io';
import 'dart:convert';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:image/image.dart' as img;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class funcionImpressUP {
  bool newverificador = false;
  List<String> imagesPath = [];
  String namePDF = "";
  List<String> caminhoPDFDelete = [];
  String textoDigit = "";
  XFile? listPdf;

  Future<void> pickImages(BuildContext context, Function setState) async {
    newverificador = false;
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
    List<String>? pickedImages = await CunningDocumentScanner.getPictures();
    if (pickedImages!.isNotEmpty) {
      for (var imagePath in pickedImages) {
        final originalImage = File(imagePath);
        final bytes = await originalImage.readAsBytes();
        final image = img.decodeImage(bytes);
        final blackAndWhiteImage = img.grayscale(image!);

        final newImagePath = imagePath.replaceAll('.jpg', '_bw.jpg');
        File(newImagePath).writeAsBytesSync(img.encodeJpg(blackAndWhiteImage));
        imagesPath.add(newImagePath);
        await originalImage.delete();
      }

      await convertImagesToPdf(imagesPath, setState);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> convertImagesToPdf(
      List<String> imagesPath, Function setState) async {
    if (imagesPath.isNotEmpty) {
      final pdf = pdfWidgets.Document();
      for (var imagePath in imagesPath) {
        final pdfImage =
            pdfWidgets.MemoryImage(File(imagePath).readAsBytesSync());
        pdf.addPage(
          pdfWidgets.Page(
            build: (context) => pdfWidgets.Image(pdfImage),
          ),
        );
      }

      final appDir = await getExternalStorageDirectory();
      final name = DateTime.now().millisecondsSinceEpoch;
      namePDF = name.toString();
      final caminhoPdf =
          '${appDir!.path}/$name.pdf'; // Usar o caminho do armazenamento externo
      final arquivoPdf = File(caminhoPdf);
      arquivoPdf.writeAsBytesSync(await pdf.save());

      print("PDF saved at: ${arquivoPdf.path}");
      caminhoPDFDelete.add(arquivoPdf.path);
      await saveList(caminhoPDFDelete);

      textoDigit = arquivoPdf.path;

      listPdf = XFile(arquivoPdf.path);
      newverificador = true;
      setState();

      // Compartilhar o arquivo PDF
      await Share.shareXFiles([XFile(arquivoPdf.path)],
          text: 'Compartilhando PDF');

      for (var imagePath in imagesPath) {
        File(imagePath).delete();
      }

      imagesPath.clear();
      setState();
    }
  }

  // Função para salvar a lista no armazenamento local
  Future<void> saveList(List<String> myList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('myListKey', myList);
  }

// Função para recuperar a lista do armazenamento local
  Future<List<String>> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('myListKey') ??
        []; // Retorna uma lista vazia caso não haja valor salvo
  }

  Future<void> delListPDF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('myListKey')) {
      List<String>? lista = prefs.getStringList('myListKey');
      for (var caminho in lista!) {
        File(caminho).delete();
      }
    }
  }
}
