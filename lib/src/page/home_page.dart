import 'package:flutter/material.dart';
import 'package:leitor_ebooks/src/constants/custom_card.dart';
import 'package:leitor_ebooks/src/model/books_model.dart';
import 'package:leitor_ebooks/src/repository/books_repository_imp.dart';
import 'package:leitor_ebooks/src/service/dio_service.dart';
import 'package:leitor_ebooks/src/service/dio_service_imp.dart';
import 'package:leitor_ebooks/src/service/vocsy_epub_open.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DioServiceImp dioServiceImp = DioServiceImp();
  VocsyEpubOpen vocsyEpubOpen = VocsyEpubOpen();
  late DioService dioService;

  var booksRepositoryImp = BooksRepositoryImp(
    DioServiceImp(),
  );
  var booksModel = <BooksModel>[];
  List<BooksModel> favoriteBooks = [];
  bool isFavorite = false;

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

  void toggleFavorite(BooksModel book) {
    setState(() {
      if (favoriteBooks.contains(book)) {
        favoriteBooks.remove(book);
      } else {
        favoriteBooks.add(book);
      }
    });
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
          backgroundColor: const Color.fromARGB(255, 7, 85, 255),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Container(
                color: isFavorite ? Colors.green : Colors.white,
                width: 80,
                height: 35,
                child: const Center(
                  child: Text(
                    "Favoritos",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: isFavorite == false
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: booksModel.length,
                itemBuilder: (_, index) {
                  var book = booksModel[index];
                  return CustomCard(
                    dioServiceImp: dioServiceImp,
                    favoriteBooks: favoriteBooks,
                    vocsyEpubOpen: vocsyEpubOpen,
                    book: book,
                  );
                },
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: favoriteBooks.length,
                itemBuilder: (_, index) {
                  var book = favoriteBooks[index];
                  return CustomCard(
                    dioServiceImp: dioServiceImp,
                    favoriteBooks: favoriteBooks,
                    vocsyEpubOpen: vocsyEpubOpen,
                    book: book,
                  );
                },
              ),
      ),
    );
  }
}
