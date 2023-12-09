import 'package:dio/dio.dart';
import 'package:leitor_ebooks/src/model/books_model.dart';

abstract class DioService {
  Dio getDio();
  Future<String> downloadDio(BooksModel url);
}
