import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:leitor_ebooks/src/model/books_model.dart';
import 'package:leitor_ebooks/src/service/dio_service.dart';
import 'package:path_provider/path_provider.dart';

class DioServiceImp implements DioService {
  @override
  Dio getDio() {
    return Dio();
  }

  @override
  Future<String> downloadDio(BooksModel book) async {
    Dio dio = Dio();

    try {
      String documentsDir = (await getApplicationDocumentsDirectory()).path;
      String? fileUrl = book.downloadUrl;
      String filePath = '$documentsDir/${book.title}.epub';

      await dio.download(
        fileUrl!,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            debugPrint("${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      debugPrint('Download concluído. Arquivo salvo em: $filePath');
      return filePath;
    } catch (e) {
      throw 'Erro durante o download: $e';
    }
  }
}
