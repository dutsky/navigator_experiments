import 'package:flutter/material.dart';
import 'package:navitator_experiments/data/book.dart';

class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  const BooksListScreen({
    required this.books,
    required this.onTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: ((context, index) => ListTile(
                  title: Text(books[index].title),
                  subtitle: Text(books[index].author),
                  onTap: () => onTapped(books[index]),
                )),
          ),
        ),
      ),
    );
  }
}
