import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/modules/register_screen/cubit/cubit.dart';
import 'package:socialapp/modules/register_screen/cubit/states.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/network/local/shared_helper.dart';

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
            navigateAndFinish(context: context, widget: HomeLayout());
          //  customizedToast(message: message, toastState: ToastState.SUCESS);
          }).catchError((error) {});
        }
        else{
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
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Center(
              child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    child: Text("Hello Register to get \n Started",
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
                      buttonColor: Colors.black,
                      buttonText: "Register",
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
                  )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
