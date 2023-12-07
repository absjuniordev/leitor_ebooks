import 'package:leitor_ebooks/src/model/books_model.dart';
import 'package:leitor_ebooks/src/repository/books_repository.dart';
import 'package:leitor_ebooks/src/service/dio_service.dart';
import 'package:leitor_ebooks/src/utils/api.utils.dart';

class BooksRepositoryImp implements BooksRepository {
  final DioService _dioService;
  BooksRepositoryImp(this._dioService);

  @override
  Future<List<BooksModel>> getBooks() async {
    var response = await _dioService.getDio().get(API.REQUEST_BOOK_LIST);

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => BooksModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
