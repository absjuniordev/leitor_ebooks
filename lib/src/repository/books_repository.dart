import 'package:leitor_ebooks/src/model/books_model.dart';

abstract class BooksRepository {
  Future<List<BooksModel>> getBooks();
}
