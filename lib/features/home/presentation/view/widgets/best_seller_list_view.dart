import 'package:flutter/material.dart';

import 'best_seller_card.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          BestSellerCard(imagePath: 'assets/images/Rectangle 128.png', price: '\$103.0'),
          BestSellerCard(imagePath: 'assets/images/Rectangle 128.png', price: '\$50.0'),
          BestSellerCard(imagePath: 'assets/images/Rectangle 128.png', price: '\$12.99'),
          BestSellerCard(imagePath: 'assets/images/Rectangle 128.png', price: '\$8.20'),
        ],
      ),
    );
  }
}
