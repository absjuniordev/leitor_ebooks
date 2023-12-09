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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "eBooks",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 7, 85, 255)),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8),
          itemCount: booksModel.length,
          itemBuilder: (_, index) {
            var book = booksModel[index];
            return Card(
              elevation: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      book.coverUrl.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    book.title.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    book.author.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
