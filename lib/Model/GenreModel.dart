class GenreModel {
  final String id;
  final String name;
  final String image;

  GenreModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['_id'], name: json['name'], image: json['image']);
  }
}
