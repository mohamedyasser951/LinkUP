import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/add_post/add_post.dart';
import 'package:socialapp/modules/chats/chat_screen.dart';
import 'package:socialapp/modules/home/home.dart';
import 'package:socialapp/modules/settings/setting_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutIntialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  late UserModel userModel;

  void getUserData({required String uId}) async {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSucessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState());
    });
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
    print(currentIndex);
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
}
