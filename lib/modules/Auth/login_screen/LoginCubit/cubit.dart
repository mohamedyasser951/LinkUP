import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/Auth/login_screen/LoginCubit/states.dart';

class CubitLogin extends Cubit<SocialLoginStates> {
  CubitLogin() : super(SocialLoginInitialState());

  static CubitLogin get(context) => BlocProvider.of(context);

  UserModel? loginModel;
  userLogin({
    required String email,
    required String password,
  }) async {
    emit(SocialLoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
     
      print(value);
      print("login success");
      emit(SocialLoginSuccesState(uId: value.user!.uid));
    }).catchError((e) {
      emit(SocialLoginErrorState());
    });
  }

  bool isPassword = true;
  IconData sufficIcon = Icons.visibility;

  changeVisibility() {
    isPassword = !isPassword;
    sufficIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialLoginChangeVisibilityState());
  }
}
