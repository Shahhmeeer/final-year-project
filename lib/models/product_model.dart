class Product {
  final int id;
  final String name;
  final int price;
  final String category;
  final String imageUrl;
  bool isFavourite;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.isFavourite = false,
  });
}
