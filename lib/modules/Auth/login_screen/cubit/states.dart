class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccesState extends SocialLoginStates {
  final String uId;

  SocialLoginSuccesState({required this.uId});
}

class SocialLoginErrorState extends SocialLoginStates {}

class SocialLoginChangeVisibilityState extends SocialLoginStates {}
