import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/modules/login_screen/cubit/cubit.dart';
import 'package:socialapp/modules/login_screen/cubit/states.dart';

import 'package:socialapp/shared/componenet/component.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitLogin, SocialLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CubitLogin.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
          
              body: SafeArea(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 10),
                                child: Text("Welcome Back! Glad \nto see you again",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              CustomizedTextfield(
                                hintText: "Email",
                                myController: email,
                                isPassword: false,
                              ),
                              CustomizedTextfield(
                                hintText: "Password",
                                myController: password,
                                isPassword: cubit.isPassword,
                                suffixIcon: cubit.sufficIcon,
                                suffixPressed: () {
                                  cubit.changeVisibility();
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
                              CustomizedButton(
                                buttonText: "Login",
                                buttonColor: Color.fromARGB(255, 0, 0, 0),
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         height: 1,
                              //         width:
                              //             MediaQuery.of(context).size.height * 0.18,
                              //         color: Colors.grey,
                              //       ),
                              //       const Text("Or Login with"),
                              //       Container(
                              //         height: 1,
                              //         width:
                              //             MediaQuery.of(context).size.height * 0.18,
                              //         color: Colors.grey,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //     children: [
                              //       Container(
                              //           height: 50,
                              //           width: 100,
                              //           decoration: BoxDecoration(
                              //             border: Border.all(
                              //                 color: Colors.black, width: 1),
                              //             borderRadius: BorderRadius.circular(10),
                              //           ),
                              //           child: IconButton(
                              //             icon: const Icon(
                              //               FontAwesomeIcons.facebookF,
                              //               color: Colors.blue,
                              //             ),
                              //             onPressed: () {},
                              //           )),
                              //       Container(
                              //         height: 50,
                              //         width: 100,
                              //         decoration: BoxDecoration(
                              //           border: Border.all(
                              //               color: Colors.black, width: 1),
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         child: IconButton(
                              //           icon:  const Icon(
                              //             FontAwesomeIcons.google,
                                       
                              //           ),
                              //           onPressed: () async {},
                              //         ),
                              //       ),
                              //       Container(
                              //           height: 50,
                              //           width: 100,
                              //           decoration: BoxDecoration(
                              //             border: Border.all(
                              //                 color: Colors.black, width: 1),
                              //             borderRadius: BorderRadius.circular(10),
                              //           ),
                              //           child: IconButton(
                              //             icon: const Icon(
                              //               FontAwesomeIcons.apple,
                                          
                              //             ),
                              //             onPressed: () {},
                              //           ))
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(
                                height: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(48, 8, 8, 8.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text("Don't have an account?",
                                        style: TextStyle(
                                          color: Color(0xff1E232C),
                                          fontSize: 15,
                                        )),
                                    Text("  Register Now",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        )),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    )),
              ));
        });
  }
}
