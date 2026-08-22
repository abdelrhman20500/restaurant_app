import 'package:flutter/material.dart';
import 'package:restaurant_app/Core/widget/custom_button.dart';
import '../../../../Core/utilis/styles.dart';
import '../../data/models/products_model.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductsModel product; // غيّر الاسم لو الموديل عندك اسمه مختلف

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFF7CA53),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black87),
                      ),
                      const SizedBox(width: 8),
                      Text(product.name, style: Styles.style18.copyWith(color: Colors.black)), // كان ثابت "Mexican Appetizer"
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.favorite_border, color: Color(0xFFE95425), size: 22),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 12),
            child: Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFE95425), size: 16),
                const SizedBox(width: 4),
                Text(product.rating.toStringAsFixed(1), style: Styles.style14.copyWith(color: Colors.black)), // كان ثابت "5.0"
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: product.imageUrl.startsWith('http')
                            ? Image.network(product.imageUrl, height: 220, width: double.infinity, fit: BoxFit.cover)
                            : Image.asset(product.imageUrl, height: 220, width: double.infinity, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${product.price.toStringAsFixed(2)}', style: Styles.style24.copyWith(color: const Color(0xFFE95425))), // كان ثابت "$50.00"
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) setState(() => quantity--);
                              },
                              child: Container(
                                height: 32, width: 32,
                                decoration: BoxDecoration(color: const Color(0xFFFFE8DF), borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.remove, size: 18, color: Color(0xFFE95425)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: Text('$quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => quantity++),
                              child: Container(
                                height: 32, width: 32,
                                decoration: BoxDecoration(color: const Color(0xFFE95425), borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.add, size: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(product.description, style: Styles.style16.copyWith(color: Colors.black)), // كان ثابت "Tortilla Chips With Toppins"
                    const SizedBox(height: 40),
                    CustomButton(text: "Add to Cart", color: const Color(0xFFE95425), onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}