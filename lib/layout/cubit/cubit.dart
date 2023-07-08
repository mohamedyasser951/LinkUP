// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/likes_model.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/Profile/profile.dart';
import 'package:socialapp/modules/add_post/add_post.dart';
import 'package:socialapp/modules/chats/chat_screen.dart';
import 'package:socialapp/modules/home/home.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../modules/Search/search_screen.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutIntialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  UserModel? getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());

      emit(SocialGetUserSucessState());
      getUserPosts(userId: uId!);
    }).catchError((error) {
      emit(SocialGetUserErrorState());
    });
    return userModel;
  }

  void search({required String searchText}) {
    emit(SearchLoadingState());
    FirebaseFirestore.instance
        .collection("Users")
        .where("name", isEqualTo: searchText)
        .get()
        .then((value) {
      emit(SearchSuceessState(users: value.docs));
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error: error.toString()));
    });
  }

  List<PostModel> userPosts = [];

  void getUserPosts({required String userId}) {
    emit(GetUserPostsLoadingState());
    FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      userPosts = [];
      for (var element in event.docs) {
        if (element.data()["uId"] == userId) {
          userPosts.add(PostModel.fromJson(element.data()));
        }
      }
    });
  }

  List<UserModel> users = [];

  getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection("Users").get().then((value) {
        value.docs.forEach(
          (element) {
            if (element.data()['uId'] != userModel!.uId) {
              users.add(UserModel.fromJson(element.data()));
            }
          },
        );
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState());
      });
    }
  }

  int currentIndex = 0;

  changeBottomNav(int index) {
    if (index == 3) {
      getAllUsers();
    }

    if (index == 2) {
      emit(SocialNewPostAtate());
    } else {
      currentIndex = index;
      emit(HomeChangeBottomNavState());
    }
  }

  var picker = ImagePicker();
  File? profileImage;
  getProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccesState());
    } else {
      print("No image Selected");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  getCoverImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccesState());
    } else {
      emit(SocialCoverImagePickedErrorState());
      print("error When picked cover..");
    }
  }

  uploadProfileImag({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("user/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        updateUserData(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageSuccessState());
      });
    }).catchError((e) {
      emit(SocialUploadProfileImageSuccessState());
    });
  }

  uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("user/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //   emit(SocialUploadCoveImageSuccessState());
        updateUserData(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((e) {
        emit(SocialUploadCoveImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadCoveImageErrorState());
    });
  }

  updateUserData({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }) async {
    UserModel model = UserModel(
        name: name,
        bio: bio,
        phone: phone,
        cover: cover ?? userModel!.cover,
        image: image ?? userModel!.image,
        email: userModel!.email,
        uId: userModel!.uId);

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel!.uId)
        .update(model.toJson())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserDataErrorState());
    });
  }

  File? postImage;
  getPostImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPickedPostImageSuccessState());
    } else {
      print("no file picked");
      emit(SocialPickedPostImageErrorState());
    }
  }

  //create new post

  void createNewPost({
    required String postText,
    required String dateTime,
    String? postImage,
  }) async {
    PostModel postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      postImage: postImage ?? '',
      text: postText,
      dateTime: dateTime,
    );
    emit(SocialCreateNewPostLoadingState());
    FirebaseFirestore.instance
        .collection("Posts")
        .add(postModel.toJson())
        .then((value) {
      //comment here and i removed it
      emit(SocialCreateNewPostSuccessState());
    }).catchError((error) {
      emit(SocialCreateNewPostErrorState());
    });
  }

  void uplaodPostImage({
    required String postText,
    required String dateTime,
  }) async {
    emit(SocialUploadNewPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref("post")
        .child(Uri.file(postImage!.path).pathSegments.last)
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(postText: postText, dateTime: dateTime, postImage: value);
        emit(SocialUploadNewPostImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadNewPostImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadNewPostImageErrorState());
    });
  }

  removePostImage() {
    postImage = null;
    emit(SocialDeletePostImageState());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  List<LikesModel> peopleReacted = [];

  getLikes({required posId}) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(posId)
        .collection('likes')
        .snapshots()
        .listen((value) {
      for (var element in value.docs) {
        element.reference.collection("Likes").get().then((value) {
          peopleReacted.add(LikesModel.fromJson(element.data()));
        });
      }
      emit(GetLikesSuccessState());
    });
  }

  likePost({required String posId}) {
    LikesModel likesModel = LikesModel(
      uId: userModel!.uId,
      name: userModel!.name,
      profilePicture: userModel!.image,
      dateTime: FieldValue.serverTimestamp(),
    );
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(posId)
        .collection("Likes")
        .doc(userModel!.uId)
        .set(likesModel.toMap())
        .then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      print("error when Like $error");

      emit(LikePostErrorState());
    });
  }

  disLike({required String postId}) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postId)
        .collection("Likes")
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      ///////////////////////////important
      getPosts();
      emit(DisLikePostSuccessState());
    }).catchError((error) {
      print("error when disLike $error");
      emit(DisLikePostErrorState());
    });
  }

  Future<bool> likedByMe({required String postId}) async {
    bool isLikedByMe = false;

    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postId)
        .collection("Likes")
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.id == userModel!.uId) {
          isLikedByMe = true;
          disLike(postId: postId);
        }
      }
      if (isLikedByMe == false) {
        likePost(posId: postId);
      }
      emit(ChangeLikeState());
    });
    
    print(isLikedByMe);

    return isLikedByMe;
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    AddPost(),
    const ChatScreen(),
    ProfileScreen(),
  ];
}
