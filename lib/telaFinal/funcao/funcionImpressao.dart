import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';

class ImpressaoUp {
  Future<void> getImageGallery(BuildContext context) async {
    try {
      var scannedDoc = await DocumentScannerFlutter.launch(context,
          source: ScannerFileSource.GALLERY); // Or ScannerFileSource.GALLERY
      // `scannedDoc` will be the image file scanned from scanner
    } catch (error, stackTrace) {
      // 'Failed to get document path or operation cancelled!';
      print('Erro: $error');
      print('StackTrace: $stackTrace');
    }
  }

  Future<void> getImageCamera(BuildContext context) async {
    try {
      var scannedDoc = await DocumentScannerFlutter.launch(context,
          source: ScannerFileSource.CAMERA); // Or ScannerFileSource.GALLERY
      // `scannedDoc` will be the image file scanned from scanner
    } catch (error, stackTrace) {
      // 'Failed to get document path or operation cancelled!';
      print('Erro: $error');
      print('StackTrace: $stackTrace');
    }
  }
}
