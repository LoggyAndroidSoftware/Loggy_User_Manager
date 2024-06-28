class Line {
  final int id;
  final String name;
  final String description;
  final String image;

  Line({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
