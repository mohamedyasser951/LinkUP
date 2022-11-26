import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/modules/register_screen/cubit/cubit.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: ((context, state) {}),
      builder: ((context, state) {
        var model = HomeLayoutCubit.get(context).userModel;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://mcdn.wallpapersafari.com/medium/13/61/AZoLjJ.jpg")),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).backgroundColor,
                        radius: 64.0,
                        child: const CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              "https://i.pinimg.com/564x/a8/59/4c/a8594c270956433c38513751e3b64c80.jpg"),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  "Mohamed Yasser",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  "bio...",
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
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {}, child: const Text("AddPhoto"))),
                    const SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                        onPressed: () {},
                        child: Icon(
                          IconBroken.Edit,
                          size: 16.0,
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
