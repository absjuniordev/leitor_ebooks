import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class ViewerEbookPage extends StatefulWidget {
  final String epubFilePath;
  final String epubTitle;
  const ViewerEbookPage(
      {super.key, required this.epubFilePath, required this.epubTitle});

  @override
  State<ViewerEbookPage> createState() => _ViewerEbookPageState();
}

class _ViewerEbookPageState extends State<ViewerEbookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.epubTitle),
      ),
      body: FutureBuilder(
        future: VocsyEpub.openAsset(
          widget.epubFilePath,
          lastLocation: EpubLocator.fromJson({
            "bookId": "2239",
            "href": "/OEBPS/ch06.xhtml",
            "created": 1539934158390,
            "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
          }),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data ?? Container();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
