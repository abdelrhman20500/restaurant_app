import 'package:flutter/material.dart';

import '../../../../../Core/utilis/styles.dart';
import '../../view_manager/profile_cubit.dart';

void showLogoutDialog(BuildContext context, ProfileCubit cubit) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Logout", style: Styles.style22,),
      content: const Text("Are you sure you want to logout?", style: TextStyle(color: Colors.black),),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel",style: Styles.style18.copyWith(color: Colors.black),),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            cubit.signOut();
          },
          child: const Text("Logout", style: TextStyle(fontSize: 18, color: Colors.red)),
        ),
      ],
    ),
  );
}