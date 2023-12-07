import 'package:flutter/material.dart';
import 'package:leitor_ebooks/src/page/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Leitor de Ebooks',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(174, 4, 11, 73),
          ),
        ),
        home: const HomePage());
  }
}
