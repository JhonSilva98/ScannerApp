import 'dart:io';

import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';

class ImpressaoUp {
  File? pdfFinal;
  bool verificador = false;

  Future<void> getImageGallery(BuildContext context) async {
    verificador = false;
    try {
      var scannedDoc = await DocumentScannerFlutter.launchForPdf(context,
          source: ScannerFileSource.GALLERY);
      if (scannedDoc != null) {
        pdfFinal = scannedDoc;
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
        pdfFinal = scannedDoc;
        verificador = true;
      }
    } catch (error, stackTrace) {
      // 'Failed to get document path or operation cancelled!';
      print('Erro: $error');
      print('StackTrace: $stackTrace');
    }
  }
}
