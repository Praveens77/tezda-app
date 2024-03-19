class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'].toDouble(),
      category: json['category'] as String,
      image: json['image'] as String,
      isFavorite: json['isFavorite'] as bool? ??
          false, // Use a default value if 'isFavorite' is not present
    );
  }

  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      category: category,
      image: image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
