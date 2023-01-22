import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/modules/register_screen/cubit/cubit.dart';
import 'package:socialapp/modules/register_screen/cubit/states.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/network/local/shared_helper.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitRegister, SocialRegisterStates>(
      listener: (context, state) {
        if (state is SocialCreateSuccesState) {
          SharedHelper.saveData(key: "uId", value: state.userModel.uId)
              .then((value) {
            uId = state.userModel.uId;
            navigateAndFinish(context: context, widget:const HomeLayout());
            //  customizedToast(message: message, toastState: ToastState.SUCESS);
          }).catchError((error) {});
        } else {
          // customizedToast(message: message, toastState: ToastState.Error);
        }
      },
      builder: (context, state) {
        var cubit = CubitRegister.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(IconBroken.Arrow___Left_2)),
          ),
          body: Form(
          key: formkey,
          child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
             
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
                  child: Text("Sign Up ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                ),
               
               
               
                CustomizedTextfield(
                  myController: nameController,
                  hintText: "Username",
                  isPassword: false,
                  prefixIcon: Icons.person,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Username must be failed!";
                    }
                    return null;
                  },
                ),
                CustomizedTextfield(
                  myController: emailController,
                  hintText: "Email",
                  isPassword: false,
                  prefixIcon: Icons.email,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Email must be failed!";
                    }
                    return null;
                  },
                ),
                CustomizedTextfield(
                  myController: passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.lock,
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
                CustomizedTextfield(
                  myController: phoneController,
                  hintText: "Phone",
                  isPassword: false,
                  prefixIcon: Icons.phone,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Phone must be failed!";
                    }
                    return null;
                  },
                ),



                ConditionalBuilder(
                  condition: state is! SocialRegisterLoadingState,
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  builder: (context) => CustomizedButton(
                    buttonColor: primaryColor,
                    buttonText: "Sign Up",
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        cubit.userRegister(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text);
                      }
                    },
                    textColor: Colors.white,
                  ),
                ),


                    const Center(child: Text("Or Sign Up with")),

                    Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
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




              ],
            ),
          ),
          ),
          ),
        );
      },
    );
  }
}
