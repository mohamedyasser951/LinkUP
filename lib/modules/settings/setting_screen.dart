import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/modules/update_profile/update_profile_screen.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          var model = HomeLayoutCubit.get(context).userModel;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("${model.cover}")),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Theme.of(context).backgroundColor,
                          radius: 64.0,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage("${model.image}"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "${model.name}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    "${model.bio}",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                "Posts",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "265",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                "Photo",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "10k",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                "Followers",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "67",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                "Following",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {},
                                child: const Text("AddPhoto"))),
                        const SizedBox(
                          width: 10.0,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              navigateTo(
                                  context: context,
                                  widget: UpdateProfileCreen());
                            },
                            child: const Icon(
                              IconBroken.Edit,
                              size: 16.0,
                            ))
                      ],
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     OutlinedButton(
                  //         onPressed: () {
                  //           FirebaseMessaging.instance.subscribeToTopic("News");
                  //         },
                  //         child: Text("Subscripe")),
                  //     Spacer(),
                  //     OutlinedButton(
                  //         onPressed: () {
                  //           FirebaseMessaging.instance.unsubscribeFromTopic("News");
                  //         },
                  //         child: Text("Subscripe")),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
