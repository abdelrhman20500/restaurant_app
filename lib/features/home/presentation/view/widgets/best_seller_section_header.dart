import 'package:flutter/material.dart';

import '../../../../../Core/utilis/styles.dart';

class BestSellerSectionHeader extends StatelessWidget {
  const BestSellerSectionHeader({super.key, required this.text1, required this.text2,});


  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1, style: Styles.style18.copyWith(color: Colors.black)),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Text(text2, style: Styles.style12),
              const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFFE95425),),
            ],
          ),
        ),
      ],
    );
  }
}
