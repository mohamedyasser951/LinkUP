
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/Register_screen/cubit/states.dart';


class CubitRegister extends Cubit<SocialRegisterStates> {
  CubitRegister() : super(SocialRegisterInitialState());

  static CubitRegister get(context) => BlocProvider.of(context);

  bool isPassword = false;
  IconData sufficIcon = Icons.visibility;

  changeVisibility() {
    isPassword = !isPassword;
    sufficIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialRegisterChangeVisibilityState());
  }
}