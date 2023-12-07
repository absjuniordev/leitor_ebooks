import 'package:flutter/material.dart';
import 'package:leitor_ebooks/src/model/books_model.dart';
import 'package:leitor_ebooks/src/repository/books_repository_imp.dart';
import 'package:leitor_ebooks/src/service/dio_service.dart';
import 'package:leitor_ebooks/src/service/dio_service_imp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DioService dioService;
  var booksRepositoryImp = BooksRepositoryImp(DioServiceImp());
  var booksModel = <BooksModel>[];

  @override
  void initState() {
    super.initState();
    booksRepositoryImp = BooksRepositoryImp(DioServiceImp());
    carregarDados();
  }

  carregarDados() async {
    booksModel = await booksRepositoryImp.getBooks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: booksModel.length,
        itemBuilder: (_, index) {
          var book = booksModel[index];
          return Card(
            elevation: 3,
            child: Column(
              children: [
                Image.network(book.coverUrl.toString()),
                Text(
                  book.title.toString(),
                ),
                Text(
                  book.author.toString(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
