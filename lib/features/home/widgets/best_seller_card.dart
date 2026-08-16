import 'package:flutter/material.dart';

class BestSellerCard extends StatelessWidget {
  const BestSellerCard({super.key, required this.imagePath, required this.price,});

  final String imagePath;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFE95425),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
