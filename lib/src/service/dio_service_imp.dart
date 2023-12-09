import 'package:dio/dio.dart';
import 'package:leitor_ebooks/src/model/books_model.dart';
import 'package:leitor_ebooks/src/service/dio_service.dart';
import 'package:path_provider/path_provider.dart';

class DioServiceImp implements DioService {
  @override
  Dio getDio() {
    return Dio();
  }

  @override
  void downloadDio(BooksModel book) async {
    Dio dio = Dio();
    try {
      String tempDir = (await getTemporaryDirectory()).path;
      String? fileUrl = book.downloadUrl;
      String filePath = '$tempDir/${book.title}.pdf';

      await dio.download(
        fileUrl!,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      );

      print('Download concluído. Arquivo salvo em: $filePath');
    } catch (e) {
      print('Erro durante o download: $e');
    }
  }
}
