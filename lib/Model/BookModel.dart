class Book {
  final int id;
  final String title;
  final String author;
  final String genre;
  final String imageUrl;

  Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.genre,
      required this.imageUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      imageUrl: json['image_url'],
    );
  }
}
