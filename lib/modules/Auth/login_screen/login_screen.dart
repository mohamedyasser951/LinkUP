import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/modules/Auth/login_screen/cubit/cubit.dart';
import 'package:socialapp/modules/Auth/login_screen/cubit/states.dart';
import 'package:socialapp/modules/Auth/register_screen/register_screen.dart';

import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/network/local/shared_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitLogin, SocialLoginStates>(
        listener: (context, state) {
      if (state is SocialLoginSuccesState) {
        SharedHelper.saveData(key: "uId", value: state.uId).then(
          (value) {
            uId = state.uId;
            navigateAndFinish(context: context, widget: const HomeLayout());
          },
        ).catchError((error) {
          print(error.toString());
        });
      }
    }, builder: (context, state) {
      var cubit = CubitLogin.get(context);
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 12),
                          child: Text("Sign In",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        CustomizedTextfield(
                          prefixIcon: Icons.email,
                          hintText: "Email",
                          myController: email,
                          isPassword: false,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Email must be failed!";
                            }
                            return null;
                          },
                        ),
                        CustomizedTextfield(
                          prefixIcon: Icons.lock,
                          hintText: "Password",
                          myController: password,
                          isPassword: cubit.isPassword,
                          suffixIcon: cubit.sufficIcon,
                          suffixPressed: () {
                            cubit.changeVisibility();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Password must be failed!";
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const ForgotPassword()));
                              },
                              child: const Text("Forgot Password?",
                                  style: TextStyle(
                                    color: Color(0xff6A707C),
                                    fontSize: 14,
                                  )),
                            ),
                          ),
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          builder: (context) => CustomizedButton(
                            buttonText: "Sign In",
                            buttonColor: primaryColor,
                            textColor: Colors.white,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: email.text, password: password.text);
                              }
                            },
                          ),
                        ),
                        const Center(child: Text("Or Sign In with")),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: AppOutlineButton(
                                        asset: "assets/images/google.png",
                                        onTap: () {})),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: AppOutlineButton(
                                        asset: "assets/images/facebook.png",
                                        onTap: () {})),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: AppOutlineButton(
                                        asset: "assets/images/apple.png",
                                        onTap: () {}))
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?",
                                style: TextStyle(
                                  color: Color(0xff1E232C),
                                  fontSize: 15,
                                )),
                            TextButton(
                              onPressed: (() {
                                navigateTo(
                                    context: context, widget: RegisterScreen());
                              }),
                              child: const Text("Sign Up",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  )),
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ));
    });
  }
}
