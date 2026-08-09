import 'package:flutter/material.dart';
import 'features/onBoarding/presentation/view/on_boarding_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
     debugShowCheckedModeBanner: false,
      home: OnBoardingView(),
    );
  }
}


