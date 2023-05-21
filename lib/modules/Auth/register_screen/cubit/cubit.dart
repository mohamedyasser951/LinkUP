import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/Auth/register_screen/cubit/states.dart';

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
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((e) {
      emit(SocialRegisterErrorState());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) async {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        bio: "write your bio",
        cover:
            "https://images.all-free-download.com/images/graphicwebp/beach_cloud_dawn_horizon_horizontal_landscape_ocean_601821.webp",
        image:
            "https://i.pinimg.com/564x/a8/59/4c/a8594c270956433c38513751e3b64c80.jpg");
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {
      emit(SocialCreateSuccesState(userModel: userModel));
    }).catchError((e) {
      emit(SocialCreateErrorState());
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
