import 'package:flutter/material.dart';

import '../data/models/products_model.dart';
import '../presentation/view/product_details_view.dart';

class RecommendCard extends StatelessWidget {
  const RecommendCard({
    super.key,
    required this.product, // بدل ما ناخد imagePath/rating/price لوحدهم
  });

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(product: product), // ده أهم سطر - كان const ProductDetailsView() من غير بيانات
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            product.imageUrl.startsWith('http')
                ? Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            )
                : Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Text(product.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF332219))),
                    const SizedBox(width: 2),
                    const Icon(Icons.star, color: Colors.amber, size: 12),
                    const SizedBox(width: 4),
                    const Icon(Icons.favorite, color: Color(0xFFE95425), size: 12),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFFE95425), borderRadius: BorderRadius.circular(10)),
                child: Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}