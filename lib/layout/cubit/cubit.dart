import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/modules/chats/chat_screen.dart';
import 'package:socialapp/modules/home/home.dart';
import 'package:socialapp/modules/settings/setting_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutIntialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<CustomNavigationBarItem> NavigationBarItem = [
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Home),
    ),
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Chat),
    ),
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Paper_Download),
    ),
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Location),
    ),
    CustomNavigationBarItem(
      icon: Icon(IconBroken.Setting),
    ),
  ];

  List<Widget> Screens = [
    HomeScreen(),
    ChatScreen(),
    Container(),
    UsersScreen(),
    SettingScreen(),
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
}
