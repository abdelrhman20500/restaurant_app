import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBannerSlider extends StatelessWidget {
  HomeBannerSlider({super.key});

  // Instantiate the PageController inside the StatelessWidget
  final PageController pageController = PageController();

  final List<String> bannerImages = const [
    'assets/images/Rectangle 128.png',
    'assets/images/Rectangle 128.png',
    'assets/images/Rectangle 128.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Promo Banner PageView
        SizedBox(
          height: 130,
          child: PageView.builder(
            controller: pageController,
            itemCount: bannerImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(bannerImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // Smooth Page Indicator
        SmoothPageIndicator(
          controller: pageController,
          count: bannerImages.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: Color(0xFFE95425), // Primary orange
            dotColor: Color(0xFFE5ECC2),       // Light dot background
            dotHeight: 6,
            dotWidth: 16,
            expansionFactor: 2.2,             // Pill expansion effect
            spacing: 6,
          ),
        ),
      ],
    );
  }
}