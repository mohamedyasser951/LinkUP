import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/add_post/add_post.dart';
import 'package:socialapp/modules/chats/chat_screen.dart';
import 'package:socialapp/modules/home/home.dart';
import 'package:socialapp/modules/settings/setting_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/style/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutIntialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  late UserModel userModel;

  void getUserData({String? uId}) async {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      print("getuserDatamethod..........");
      userModel = UserModel.fromJson(value.data());
      print("usermodel value...........${userModel.uId}");
      emit(SocialGetUserSucessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState());
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection("Users").get().then((value) {
        value.docs.forEach(
          (element) {
            if (element.data()['uId'] != userModel.uId) {
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

  List<CustomNavigationBarItem> NavigationBarItem = [
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Home),
    ),
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Chat),
    ),
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Plus),
    ),
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Location),
    ),
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Profile),
    ),
  ];

  List<Widget> Screens = [
    HomeScreen(),
    ChatScreen(),
    AddPost(),
    UsersScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    "Home",
    "Chats",
    "addPost",
    "UsersScreen",
    "Settings",
  ];

  changeBottomNav(int index) {
    if (index == 1) {
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
        cover: cover ?? userModel.cover,
        image: image ?? userModel.image,
        email: userModel.email,
        uId: userModel.uId);

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel.uId)
        .update(model.toJson())
        .then((value) {
      getUserData(uId: userModel.uId);
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
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      postImage: postImage ?? '',
      text: postText,
      dateTime: dateTime,
    );
    emit(SocialCreateNewPostLoadingState());
    FirebaseFirestore.instance
        .collection("Posts")
        .add(postModel.toJson())
        .then((value) {
      // emit(SocialCreateNewPostSuccessState());
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

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection("Posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("Likes").get().then((value) {
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          likes.add(value.docs.length);
        }).catchError((error) {});

        emit(SocialGetPostsSuccessState());
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState());
    });
  }

  void likePost({required String posId}) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(posId)
        .collection("Likes")
        .doc(userModel.uId)
        .set({'like': 'true'}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  void sendMessage({
    String? recieverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
        sendId: userModel.uId,
        reciverId: recieverId,
        text: text,
        dateTime: dateTime);

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel.uId)
        .collection("chats")
        .doc(recieverId)
        .collection("Messages")
        .add(messageModel.toJson())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection("Users")
        .doc(recieverId)
        .collection("chats")
        .doc(userModel.uId)
        .collection("Messages")
        .add(messageModel.toJson())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }



  List<MessageModel> messages = [];
  void getMessages(
    String? recieverId,
  ) {
    
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel.uId)
        .collection("chats")
        .doc(recieverId)
        .collection("Messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        print("this is get messages methode");
        messages.add(MessageModel.fromJson(element.data()));
        emit(SocialRecieveMessageSuccessState());
       
      });
    });
  }
}
