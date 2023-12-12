import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class VocsyEpubOpen {
  Future<void> openDownloadedEpub(String filePath) async {
    try {
      VocsyEpub.setConfig(
        identifier: "iosBook",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
        nightMode: true,
      );

      VocsyEpub.locatorStream.listen((locator) {
        debugPrint('LOCATOR: $locator');
      });

      VocsyEpub.open(
        filePath,
        lastLocation: EpubLocator.fromJson({
          "bookId": "2239",
          "href": "/OEBPS/ch06.xhtml",
          "created": 1539934158390,
          "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"},
        }),
      );
    } catch (e) {
      debugPrint('Erro ao abrir o EPUB: $e');
    }
  }
}
