class Book {
  final int id;
  final String title;
  final String author;
  final String imageUrl;
  final String description;
  final double price;
  int quantity;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.quantity,

  });
 void addquan()
 {
   this.quantity+=1;
 }
  void removequan()
  {
    if(this.quantity>1) {
      this.quantity -= 1;
    }
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }
}
