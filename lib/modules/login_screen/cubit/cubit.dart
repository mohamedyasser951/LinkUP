import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/login_screen/cubit/states.dart';

class CubitLogin extends Cubit<SocialLoginStates> {
  CubitLogin() : super(SocialLoginInitialState());

  static CubitLogin get(context) => BlocProvider.of(context);

  bool isPassword = false;
  IconData sufficIcon = Icons.visibility;

  changeVisibility() {
    isPassword = !isPassword;
    sufficIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialLoginChangeVisibilityState());
  }
}
