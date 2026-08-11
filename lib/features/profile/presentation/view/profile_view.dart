import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/Core/utilis/styles.dart';
import 'package:restaurant_app/features/profile/presentation/view/widget/logout_dialog.dart';
import 'package:restaurant_app/features/profile/presentation/view/widget/profile_item.dart';
import 'package:restaurant_app/features/profile/presentation/view_manager/profile_cubit.dart';
import 'package:restaurant_app/features/profile/presentation/view_manager/profile_state.dart';
import 'package:restaurant_app/features/splash/presentation/view/splash_view.dart';
import '../../../../Core/function/snack_bar_message.dart';
import '../../data/repo/profile_repo.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileRepo())..getUserData(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSignOutSuccess) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
            const SplashView()));
          }
          if (state is ProfileSignOutFailure) {
            snackBarMessage(context: context, text: "Logout Failed: ${state.error}");
          }
          if (state is ProfileFailure) {
            snackBarMessage(context: context, text: "Failed to load profile: ${state.error}");
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileSignOutLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          }
          if (state is ProfileSuccess){
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFD54F),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/images/person.png"),
                      ),
                      const SizedBox(height: 12),
                      Text(state.userModel.name, style: Styles.style22
                      ),
                      const SizedBox(height: 4),
                      Text(state.userModel.email, style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      ProfileItem(icon: Icons.person_outline, text: "My Profile",onTap: (){},),
                      ProfileItem(icon: Icons.shopping_bag_outlined, text: "My Orders", onTap: (){},),
                      ProfileItem(icon: Icons.favorite_border, text: "My Favorites",onTap: (){}),
                      ProfileItem(icon: Icons.settings_outlined, text: "Settings",onTap: (){}),
                      ProfileItem(
                        icon: Icons.logout,
                        text: "Log Out",onTap: (){
                        showLogoutDialog(context, context.read<ProfileCubit>());
                      },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

