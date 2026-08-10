import 'package:flutter/material.dart';
import 'package:restaurant_app/Core/utilis/styles.dart';
import 'package:restaurant_app/features/splash/presentation/view/splash_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/model/on_boarding_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return buildPage(onboardingData[index]);
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(onboardingData[currentIndex].icon,
                    height: 40, color: const Color(0xFFFF6B00),),
                  const SizedBox(height: 16),
                  Text(onboardingData[currentIndex].title, style: Styles.style24),
                  const SizedBox(height: 12),
                  Text(onboardingData[currentIndex].description,
                    textAlign: TextAlign.center,style: Styles.style14),
                  const SizedBox(height: 24),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: onboardingData.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xFFFF6B00),
                      dotColor: Color(0xFFFFD8B0),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentIndex == onboardingData.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SplashView()),
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        currentIndex == onboardingData.length - 1
                            ? "Get Started" : "Next",
                        style: Styles.style16
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(OnboardingItem item) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Image.asset(
            item.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const Expanded(flex: 4, child: SizedBox()),
      ],
    );
  }
}