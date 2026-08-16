import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/Core/utilis/styles.dart';
import 'package:restaurant_app/Core/widget/custom_button.dart';

import '../../../../Core/routing/app_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE95425),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Group 270.png"),
              Text(
                "Lorem ipsum dolor sit amet, consectetur\n     adipiscing elit, sed do eiusmod.",
                style: Styles.style14.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomButton(
                  text: "Login",
                  textStyle:
                      const TextStyle(color: Color(0xffE95322), fontSize: 20),
                  width: 140,
                  color: const Color(0xffF5CB58),
                  onPressed: () {
                    context.go(AppRouter.login);
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const LoginView()));
                    // }
                  }),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                  text: "SignUp",
                  textStyle:
                      const TextStyle(color: Color(0xffE95322), fontSize: 20),
                  width: 140,
                  color: const Color(0xffF3E9B5),
                  onPressed: () {
                    context.go(AppRouter.signUp);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignUpView()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
