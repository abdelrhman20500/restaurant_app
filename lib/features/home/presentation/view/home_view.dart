import 'package:flutter/material.dart';
import 'package:restaurant_app/features/home/presentation/view/widgets/best_seller_list_view.dart';
import 'package:restaurant_app/features/home/presentation/view/widgets/best_seller_section_header.dart';
import 'package:restaurant_app/features/home/presentation/view/widgets/home_banner_slider.dart';
import 'package:restaurant_app/features/home/presentation/view/widgets/recommend_grid_view.dart';
import '../../../../Core/utilis/styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF7CA53),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 42,
                      width: 42,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined, color: Color(0xFFE95425), size: 22,),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Good Morning', style: Styles.style28),
                const SizedBox(height: 2),
                Text('Rise And Shine! It\'s Breakfast Time',
                  style: Styles.style14.copyWith(color: const Color(0xFFE95425)),),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BestSellerSectionHeader(text1: "Best Seller",text2: "View All",),
                    const SizedBox(height: 12),
                    const BestSellerListView(),
                    const SizedBox(height: 20),
                    HomeBannerSlider(),
                    const SizedBox(height: 20),
                    Text('Recommend', style:Styles.style18.copyWith(color: Colors.black)),
                    const SizedBox(height: 12),
                    const RecommendGridView(),
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



