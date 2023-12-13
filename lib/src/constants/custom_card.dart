import 'package:flutter/material.dart';
import 'package:leitor_ebooks/src/model/books_model.dart';
import 'package:leitor_ebooks/src/service/dio_service_imp.dart';
import 'package:leitor_ebooks/src/service/vocsy_epub_open.dart';

// ignore: must_be_immutable
class CustomCard extends StatefulWidget {
  BooksModel book;
  DioServiceImp dioServiceImp;
  VocsyEpubOpen vocsyEpubOpen;
  List<BooksModel> favoriteBooks = [];
  CustomCard({
    Key? key,
    required this.book,
    required this.favoriteBooks,
    required this.dioServiceImp,
    required this.vocsyEpubOpen,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  var booksModel = <BooksModel>[];

  void toggleFavorite(BooksModel book) {
    setState(() {
      if (widget.favoriteBooks.contains(book)) {
        widget.favoriteBooks.remove(book);
      } else {
        widget.favoriteBooks.add(book);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () async {
          String epubFilePath =
              await widget.dioServiceImp.downloadDio(widget.book);
          if (epubFilePath.isNotEmpty) {
            await widget.vocsyEpubOpen.openDownloadedEpub(epubFilePath);
          }
        },
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  iconSize: 40,
                  icon: Icon(
                    widget.favoriteBooks.contains(widget.book)
                        ? Icons.star
                        : Icons.star_border,
                    color: widget.favoriteBooks.contains(widget.book)
                        ? const Color.fromARGB(255, 158, 12, 1)
                        : null,
                  ),
                  onPressed: () {
                    toggleFavorite(widget.book);
                  },
                ),
              ],
            ),
            Expanded(
              child: Image.network(
                widget.book.coverUrl.toString(),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.book.title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.book.author.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
