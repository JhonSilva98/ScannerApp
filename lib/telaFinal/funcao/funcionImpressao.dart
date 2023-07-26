import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';

class ImpressaoUp {
  String pdfFinal = "";
  bool verificador = false;

  Future<void> getImageGallery(BuildContext context) async {
    verificador = false;
    try {
      var scannedDoc = await DocumentScannerFlutter.launch(context,
          source: ScannerFileSource.GALLERY);
      if (scannedDoc != null) {
        pdfFinal = scannedDoc.path;
        verificador = true;
      }
      // `scannedDoc` will be the image file scanned from scanner
    } catch (error, stackTrace) {
      // 'Failed to get document path or operation cancelled!';
      print('Erro: $error');
      print('StackTrace: $stackTrace');
    }
  }

  Future<void> getImageCamera(BuildContext context) async {
    verificador = false;
    try {
      var scannedDoc = await DocumentScannerFlutter.launchForPdf(context,
          source: ScannerFileSource.CAMERA);
      if (scannedDoc != null) {
        pdfFinal = scannedDoc.path;
        verificador = true;
      }
    } catch (error, stackTrace) {
      // 'Failed to get document path or operation cancelled!';
      print('Erro: $error');
      print('StackTrace: $stackTrace');
    }
  }
}
