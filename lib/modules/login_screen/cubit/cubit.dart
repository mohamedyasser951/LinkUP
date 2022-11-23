import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/login_screen/cubit/states.dart';

class CubitLogin extends Cubit<SocialLoginStates> {
  CubitLogin() : super(SocialLoginInitialState());

  static CubitLogin get(context) => BlocProvider.of(context);

  userLogin({
    required String email,
    required String password,
  }) async {
    emit(SocialLoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value);
      emit(SocialLoginSuccesState());
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
