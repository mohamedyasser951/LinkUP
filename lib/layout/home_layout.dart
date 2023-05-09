import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/modules/add_post/add_post.dart';
import 'package:socialapp/modules/chats/chat_screen.dart';
import 'package:socialapp/modules/home/home.dart';
import 'package:socialapp/modules/settings/setting_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});

  final List<CustomNavigationBarItem> navigationBarItem = [
    CustomNavigationBarItem(
      title: const Text("Feeds"),
      icon: const Icon(IconBroken.Home),
    ),
    CustomNavigationBarItem(
      title: const Text("Chats"),
      icon: const Icon(IconBroken.Chat),
    ),
    CustomNavigationBarItem(
      title: const Text("Post"),
      icon: const Icon(IconBroken.Plus),
    ),
    CustomNavigationBarItem(
      title: const Text("Users"),
      icon: const Icon(IconBroken.User1),
    ),
    CustomNavigationBarItem(
      title: const Text("Profile"),
      icon: const Icon(IconBroken.Profile),
    ),
  ];

  final List<String> titles = [
    "Feeds",
    "Chats",
    "addPost",
    "Users",
    "Profile",
  ];
  final List<Widget> Screens = [
    const HomeScreen(),
    const ChatScreen(),
    AddPost(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {
        if (state is SocialNewPostAtate) {
          navigateTo(context: context, widget: AddPost());
        }
      },
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              titles[cubit.currentIndex],
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(
                  onPressed: () {
                    // logOut(context);
                  },
                  icon: const Icon(IconBroken.Search))
            ],
          ),
          body: Screens[cubit.currentIndex],
          bottomNavigationBar: CustomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeBottomNav(index),
            items: navigationBarItem,
          ),
        );
      },
    );
  }
}
