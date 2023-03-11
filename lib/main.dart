import 'package:flutter/material.dart';
import 'CommandePage.dart';
import 'ListBook.dart';
import 'BookDetailPage.dart';
import 'PanierPage.dart';

class BookList extends StatelessWidget {
  const BookList({Set? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailPage(book: books[index]),
              ),
            );
          },
          child: ListTile(
            leading: Image.network(
              books[index].imageUrl,
              width: 100,
              height: 100,
            ),
            title: Text(books[index].title),
            subtitle: Text(books[index].author),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'App Book',
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('App Book'),
            actions: [
              IconButton(
                icon: const Icon(Icons.analytics),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommandePage(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PanierPage(),
                    ),
                  );
                },
              )
            ],
          ),
          body: const BookList(),
        ),
      ),
    ),
  );
}
