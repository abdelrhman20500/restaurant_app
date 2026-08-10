import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/Core/widget/custom_button.dart';
import 'package:restaurant_app/features/auth/data/repo/auth_repo.dart';
import 'package:restaurant_app/features/auth/presentation/view/sign_up_view.dart';
import 'package:restaurant_app/features/auth/presentation/view_manager/auth_cubit.dart';
import 'package:restaurant_app/features/auth/presentation/view_manager/auth_states.dart';
import '../../../../Core/function/snack_bar_message.dart';
import '../../../../Core/utilis/styles.dart';
import '../../../../Core/widget/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPasswordObscured = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepo()),
      child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is LoginFailure){
              snackBarMessage(context: context, text: state.error,backgroundColor: Colors.red);
            }else if(state is LoginSuccess){
              snackBarMessage(context: context, text: "Login Success", backgroundColor: Colors.green);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: const Color(0xFFF7CA53),
              body : SafeArea(
                bottom: false,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFE95425)),
                              onPressed: () => Navigator.pop,
                            ),
                            Expanded(
                              child: Text('Hello!', textAlign: TextAlign.center, style: Styles.style24),),
                            const SizedBox(width: 48), // Balance for back arrow space
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 60,),
                                Text('Welcome', style: Styles.style22),
                                const SizedBox(height: 24),
                                CustomTextField(
                                  label: 'Email',
                                  hintText: 'Enter email here',
                                  controller:emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  label: 'Password',
                                  hintText: '*************',
                                  isPassword: true,
                                  controller: passwordController,
                                  isObscure: isPasswordObscured,
                                  onToggleVisibility: () {
                                    setState(() {
                                      isPasswordObscured = !isPasswordObscured;
                                    });
                                  },
                                ),
                                const SizedBox(height: 36),
                                state is LoginLoading ? const Center(child: CircularProgressIndicator(color: Color(0xFFE95425),),):
                                CustomButton(text: "Login",onPressed: ()
                                  {
                                    if(formKey.currentState!.validate()){
                                      BlocProvider.of<AuthCubit>(context).signIn(
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim()
                                      );
                                    }
                                  },),
                                const SizedBox(height: 16,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account ?",style: Styles.style18.copyWith(color: Colors.black)),
                                    const SizedBox(width: 6),
                                    InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          const SignUpView()));
                                        },
                                        child: Text("SignUp", style:Styles.style22.copyWith(color: const Color(0xFFFF6B00)) ,)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}