class ProductsModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? categoryId;
  final double rating;
  final bool isBestSeller;
  final bool isRecommended;

  ProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.rating,
    required this.isBestSeller,
    required this.isRecommended,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] ?? '',
      categoryId: json['category_id'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      isBestSeller: json['is_best_seller'] ?? false,
      isRecommended: json['is_recommended'] ?? false,
    );
  }
}
