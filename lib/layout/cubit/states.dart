import 'package:socialapp/models/post_model.dart';

class HomeLayoutStates {}

//Initial State
class HomeLayoutIntialState extends HomeLayoutStates {}

//Bottom Navigation
class HomeChangeBottomNavState extends HomeLayoutStates {}

//GetUserStates
class SocialGetUserLoadingState extends HomeLayoutStates {}

class SocialGetUserSucessState extends HomeLayoutStates {}

class SocialGetUserErrorState extends HomeLayoutStates {}

//Search
class SearchLoadingState extends HomeLayoutStates {}

class SearchSuceessState extends HomeLayoutStates {
  List users;
  SearchSuceessState({required this.users});
}

class SearchErrorState extends HomeLayoutStates {
  final String error;
  SearchErrorState({required this.error});
}

class GetUserPostsSuccessState extends HomeLayoutStates{
}
class GetUserPostsLoadingState extends HomeLayoutStates{
}
class GetUserPostsErrorState extends HomeLayoutStates{
}



//GetAllUsersStates
class SocialGetAllUsersLoadingState extends HomeLayoutStates {}

class SocialGetAllUsersSuccessState extends HomeLayoutStates {}

class SocialGetAllUsersErrorState extends HomeLayoutStates {}

//New Post
class SocialNewPostAtate extends HomeLayoutStates {}

//PickedProfileImage

class SocialProfileImagePickedSuccesState extends HomeLayoutStates {}

class SocialProfileImagePickedErrorState extends HomeLayoutStates {}

//PickedcoverImage

class SocialCoverImagePickedSuccesState extends HomeLayoutStates {}

class SocialCoverImagePickedErrorState extends HomeLayoutStates {}

//UploadProfileImage

class SocialUploadProfileImageSuccessState extends HomeLayoutStates {}

class SocialUploadProfileImageErrorState extends HomeLayoutStates {}

//UploadCoverImage

class SocialUploadCoveImageSuccessState extends HomeLayoutStates {}

class SocialUploadCoveImageErrorState extends HomeLayoutStates {}

//updateUserData

class SocialUpdateUserDataLoadingState extends HomeLayoutStates {}

// class SocialUpdateUserDataSuccessState extends HomeLayoutStates {}

class SocialUpdateUserDataErrorState extends HomeLayoutStates {}

//pickedPostImage
class SocialPickedPostImageSuccessState extends HomeLayoutStates {}

class SocialPickedPostImageErrorState extends HomeLayoutStates {}

//crate new post
class SocialCreateNewPostLoadingState extends HomeLayoutStates {}

class SocialCreateNewPostSuccessState extends HomeLayoutStates {}

class SocialCreateNewPostErrorState extends HomeLayoutStates {}

//Uplaod new postImage

class SocialUploadNewPostImageLoadingState extends HomeLayoutStates {}

class SocialUploadNewPostImageSuccessState extends HomeLayoutStates {}

class SocialUploadNewPostImageErrorState extends HomeLayoutStates {}

class SocialDeletePostImageState extends HomeLayoutStates {}

//Get Posts

class SocialGetPostsSuccessState extends HomeLayoutStates {
  List<PostModel> posts;
  SocialGetPostsSuccessState({required this.posts});
}

class SocialGetPostsLoadingState extends HomeLayoutStates {}

class SocialGetPostsErrorState extends HomeLayoutStates {}

//Like Post
class LikePostSuccessState extends HomeLayoutStates {}
class LikePostErrorState extends HomeLayoutStates {}


//Dis likes
class DisLikePostSuccessState extends HomeLayoutStates {}
class DisLikePostErrorState extends HomeLayoutStates {}


// Get Likes
class GetLikesSuccessState extends HomeLayoutStates {}
class GetLikesErrorState extends HomeLayoutStates {}


//checked liked
class ChangeLikeState extends HomeLayoutIntialState {}



