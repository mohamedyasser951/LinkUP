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

//pickedPostImage
class SocialPickedPostImageSuccessState extends HomeLayoutStates{}
class SocialPickedPostImageErrorState extends HomeLayoutStates{}

//crate new post
class SocialCreateNewPostLoadingState extends HomeLayoutIntialState {}
class SocialCreateNewPostSuccessState extends HomeLayoutIntialState {}
class SocialCreateNewPostErrorState extends HomeLayoutIntialState {}

//Uplaod new postImage

class SocialUploadNewPostImageLoadingState extends HomeLayoutIntialState {}
class SocialUploadNewPostImageSuccessState extends HomeLayoutIntialState {}
class SocialUploadNewPostImageErrorState extends HomeLayoutIntialState {}

class SocialDeletePostImageState extends HomeLayoutStates{}


//Get Posts

class SocialGetPostsSuccessState extends HomeLayoutIntialState{}
class SocialGetPostsLoadingState extends HomeLayoutIntialState{}
class SocialGetPostsErrorState extends HomeLayoutIntialState{}



