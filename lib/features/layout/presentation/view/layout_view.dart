import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/menu/presentation/view/menu_view.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../profile/presentation/view/profile_view.dart';
import '../view_manager/nav_bar_cubit.dart';
import '../view_manager/nav_bar_state.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});
  static const String routeName ="LayoutScreen";

  @override
  State<LayoutView> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutView> {
  final List<Widget> tabs=[
    const HomeView(),
    const MenuView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<NavBarCubit>(context);
          return Scaffold(
            body: SafeArea(
                child: tabs[cubit.currentIndex]),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22)
              ),
              child: BottomNavigationBar(
                  backgroundColor:const Color(0xffE95322) ,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: const Color.fromARGB(255, 202, 199, 199),
                  selectedIconTheme: const IconThemeData(size: 28),
                  unselectedIconTheme: const IconThemeData(size: 24),
                  selectedLabelStyle: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600,),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500),
                  currentIndex: cubit.currentIndex,
                  onTap: (index){
                    setState(() {
                      cubit.currentIndex =index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
                    BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Menu"),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
