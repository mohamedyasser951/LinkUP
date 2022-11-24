import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeLayout extends StatelessWidget {
   HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
           actions: [
            IconButton(onPressed: (){}, icon: const Icon(IconBroken.Notification)),
             IconButton(onPressed: (){}, icon:const Icon(IconBroken.Search))
           ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: CustomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) =>  cubit.changeBottomNav(index),
            items: cubit.NavigationBarItem,
          ),
        );
      },
    );
  }
}
