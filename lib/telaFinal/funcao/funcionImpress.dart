import 'dart:io';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:image/image.dart' as img;
import 'package:share_plus/share_plus.dart';

class FuncionImpressUP {
  bool newverificador = false;
  List<String> imagesPath = [];
  String namePDF = "";
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
        //final imageGrey = img.grayscale(image!);
        final blackAndWhiteImage = img.adjustColor(image!,
            gamma: 1,
            contrast: 1,
            brightness: 1,
            exposure: 1,
            saturation: 1); //img.grayscale(image!);

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

      textoDigit = arquivoPdf.path;

      listPdf = XFile(arquivoPdf.path);
      newverificador = true;
      setState();

      for (var imagePath in imagesPath) {
        File(imagePath).delete();
      }

      imagesPath.clear();
      setState();
    }
  }
}
