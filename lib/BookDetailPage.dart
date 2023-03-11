import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Book.dart';
import 'DatabaseHelper.dart';
import 'PanierPage.dart';

class BookDetailPage extends StatefulWidget {
   final Book book;


  BookDetailPage({required this.book});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int _quantity = 1;

  DatabaseHelper databaseHelper = DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        actions: [
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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.book.imageUrl,
              width: 300,
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              widget.book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.book.author,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              widget.book.price.toString(),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              widget.book.description,
              style: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity: $_quantity'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity > 1) {
                            _quantity--;
                          }
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;


                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
            Center(
  child: ElevatedButton(
    onPressed: () async {
      //da5el
      Book newBook = Book(
        id: widget.book.id,
        title: widget.book.title,
        author: widget.book.author,
        imageUrl: widget.book.imageUrl,
        description: widget.book.description,
        price: widget.book.price,
        quantity: _quantity,
      );
      int res = await databaseHelper.saveBook(newBook);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Livre ajouté au panier'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
    },
    child: Text('Ajout au panier'),
    style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 68, 4, 162),
    ),
  ),
)
          ],
        ),
      ),
    );
  }
}


