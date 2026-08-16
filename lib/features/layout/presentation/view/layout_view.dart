import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/menu/presentation/view/menu_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../home/data/repo/categories_repo.dart';
import '../../../home/presentation/cubit/categories_cubit/categories_cubit.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../profile/presentation/view/profile_view.dart';
import '../view_manager/nav_bar_cubit.dart';
import '../view_manager/nav_bar_state.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  static const String routeName = "LayoutScreen";

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final List<Widget> tabs = const [
    HomeView(),
    MenuView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavBarCubit(),
        ),
        BlocProvider(
          create: (_) => CategoriesCubit(
            CategoriesRepo(
              Supabase.instance.client,
            ),
          )..getCategories(),
        ),
      ],
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          final cubit = context.read<NavBarCubit>();

          return Scaffold(
            backgroundColor: const Color(0xFFF7CA53),
            body: SafeArea(
              child: IndexedStack(
                index: cubit.currentIndex,
                children: tabs,
              ),
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
              child: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                backgroundColor: const Color(0xffE95322),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: const Color.fromARGB(255, 202, 199, 199),
                selectedIconTheme: const IconThemeData(
                  size: 28,
                ),
                unselectedIconTheme: const IconThemeData(
                  size: 24,
                ),
                selectedLabelStyle: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 6,
                  fontWeight: FontWeight.w500,
                ),
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant_menu_outlined),
                    activeIcon: Icon(Icons.restaurant_menu),
                    label: "Menu",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
