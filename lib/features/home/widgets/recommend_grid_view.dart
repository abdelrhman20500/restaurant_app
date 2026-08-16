import 'package:flutter/material.dart';
import 'package:restaurant_app/features/home/widgets/recommended_card.dart';

class RecommendGridView extends StatelessWidget {
  const RecommendGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.1,
      children: const [
        RecommendCard(
            imagePath: 'assets/images/Rectangle 128.png',
            rating: '5.0',
            price: '\$10.0'),
        RecommendCard(
            imagePath: 'assets/images/Rectangle 128.png',
            rating: '5.0',
            price: '\$25.0'),
        RecommendCard(
            imagePath: 'assets/images/Rectangle 128.png',
            rating: '5.0',
            price: '\$10.0'),
        RecommendCard(
            imagePath: 'assets/images/Rectangle 128.png',
            rating: '5.0',
            price: '\$25.0'),
      ],
    );
  }
}
