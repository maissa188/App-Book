import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'Book.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db = null;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "bookstore.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
     await db.execute( 
      "CREATE TABLE books( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,description TEXT,genre TEXT,year INTEGER,author TEXT,price REAL,image TEXT,createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");

    await db.execute(
        "CREATE TABLE panier(id INTEGER PRIMARY KEY, title TEXT, author TEXT, imageUrl TEXT, description TEXT, price REAL, quantity INTEGER)");
    await db.execute(
        "CREATE TABLE commande(idc INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, total REAL)");
  }




 Future<int> createBook(String title, String? description, String? genre, int? year, String? author, double? price, String? image) async {
     var dbClient = await db;

    final data = {'title': title, 'description': description, 'genre': genre, 'year': year, 'author': author, 'price': price, 'image': image};
    final id = await dbClient.insert('BOOKS', data);
    return id;
  }


  Future<int> saveBook(Book book) async {
    var dbClient = await db;
    int res = await dbClient.insert("panier", book.toMap());
    return res;
  }
  Future<int> saveCmd(String desc,double tot) async {
    var dbClient = await db;
    Map<String, dynamic> cmap = {
      'description': desc,
      'total': tot,
    };
    int res = await dbClient.insert("commande",cmap);
    return res;
  }

  Future<List<Book>> getBooks() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM panier');
    List<Book> books = [];
    for (var i = 0; i < list.length; i++) {
      var book = Book(
          id: list[i]["id"],
          title: list[i]["title"],
          author: list[i]["author"],
          imageUrl: list[i]["imageUrl"],
          description: list[i]["description"],
          price: list[i]["price"],
          quantity: list[i]["quantity"]);
      books.add(book);
    }
    return books;
  }

  Future<int> deleteBook(int id) async {
    var dbClient = await db;
    int res = await dbClient.delete("panier", where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> updateBook(Book book) async {
    var dbClient = await db;
    int res = await dbClient.update("panier", book.toMap(),
        where: "id = ?", whereArgs: [book.id]);
    return res;
  }
  Future<int> deleteAll() async {
    var dbClient = await db;
    int res = await dbClient.delete("panier");
    return res;
  }
  Future<List<Map<String, dynamic>>> getAllCommands() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list = await dbClient.rawQuery('SELECT * FROM commande');
    return list;
  }
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
