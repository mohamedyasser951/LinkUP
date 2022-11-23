import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/register_screen/cubit/states.dart';

class CubitRegister extends Cubit<SocialRegisterStates> {
  CubitRegister() : super(SocialRegisterInitialState());

  static CubitRegister get(context) => BlocProvider.of(context);

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    emit(SocialRegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("email${email}");
      print("password${password}");
      print("value${value}");
      emit(SocialRegisterSuccesState());
    }).catchError((e) {
      emit(SocialRegisterErrorState());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String Uid,
  }) async {
    emit(SocialCreateLoadingState());
    FirebaseFirestore.instance
        .collection("Users")
        .doc()
        .set({})
        .then((value) {
      emit(SocialCreateSuccesState());
    }).catchError((e) {
      emit(SocialCreateErrorState());
      print(e.toString());
    });
  }

  bool isPassword = true;
  IconData sufficIcon = Icons.visibility;

  changeVisibility() {
    isPassword = !isPassword;
    sufficIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialRegisterChangeVisibilityState());
  }
}
