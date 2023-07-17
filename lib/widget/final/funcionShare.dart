import 'package:flutter_share/flutter_share.dart';

void shareOnWhatsApp(String text) async {
  await FlutterShare.share(
      title: 'Compartilhar no WhatsApp',
      text: text,
      chooserTitle: 'Compartilhar via');
}
