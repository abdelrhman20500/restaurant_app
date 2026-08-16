import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Core/networking/supabase_service.dart';
import 'Core/routing/app_router.dart';
import 'Core/utilis/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Restaurant',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
