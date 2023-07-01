//11111111111
import 'package:socialapp/models/user_model.dart';

class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccesState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {}

class SocialCreateLoadingState extends SocialRegisterStates {}

class SocialCreateSuccesState extends SocialRegisterStates {
  final UserModel userModel;

  SocialCreateSuccesState({required this.userModel});
}

class SocialCreateErrorState extends SocialRegisterStates {}

class SocialRegisterChangeVisibilityState extends SocialRegisterStates {}
