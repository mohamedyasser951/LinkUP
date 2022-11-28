import 'package:socialapp/layout/cubit/cubit.dart';

class HomeLayoutStates {}

//Initial State
class HomeLayoutIntialState extends HomeLayoutStates {}

//Bottom Navigation
class HomeChangeBottomNavState extends HomeLayoutStates {}

//GetUserStates
class SocialGetUserLoadingState extends HomeLayoutStates {}

class SocialGetUserSucessState extends HomeLayoutStates {}

class SocialGetUserErrorState extends HomeLayoutStates {}

//New Post
class SocialNewPostAtate extends HomeLayoutStates {}

//PickedProfileImage

class SocialProfileImagePickedSuccesState extends HomeLayoutIntialState {}

class SocialProfileImagePickedErrorState extends HomeLayoutIntialState {}

//PickedcoverImage

class SocialCoverImagePickedSuccesState extends HomeLayoutIntialState {}

class SocialCoverImagePickedErrorState extends HomeLayoutIntialState {}

//UploadProfileImage

class SocialUploadProfileImageSuccessState extends HomeLayoutIntialState {}

class SocialUploadProfileImageErrorState extends HomeLayoutIntialState {}

//UploadCoverImage

class SocialUploadCoveImageSuccessState extends HomeLayoutIntialState {}

class SocialUploadCoveImageErrorState extends HomeLayoutIntialState {}

//updateUserData

class SocialUpdateUserDataLoadingState extends HomeLayoutIntialState {}

// class SocialUpdateUserDataSuccessState extends HomeLayoutIntialState {}

class SocialUpdateUserDataErrorState extends HomeLayoutIntialState {}


