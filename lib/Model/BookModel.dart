class BookModel {
  final String id;
  final String bookName;
  final String authorName;
  final String edition;
  final String condition;
  final String image;
  final String genre;

  BookModel({
    required this.id,
    required this.bookName,
    required this.authorName,
    required this.edition,
    required this.condition,
    required this.image,
    required this.genre,
  });

  // A factory constructor to create a book from JSON
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['_id'],
      bookName: json['bookName'],
      authorName: json['authorName'],
      edition: json['edition'],
      condition: json['condition'],
      image: json['image'],
      genre: json['genre'],
    );
  }
}
