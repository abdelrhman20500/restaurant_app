import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/home/presentation/view/cart_view.dart';
import 'package:restaurant_app/features/layout/presentation/view/layout_view.dart';
import 'Core/networking/supabase_service.dart';
import 'Core/utilis/simple_bloc_observer.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Restaurant',
     debugShowCheckedModeBanner: false,
      home: CartView(),
    );
  }
}


