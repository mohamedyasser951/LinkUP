import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/update_profile/update_profile_screen.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';
import 'package:socialapp/shared/widgets/post_item.dart';

class ProfileScreen extends StatelessWidget {
  UserModel? model;
  ProfileScreen({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    if (model?.uId == null ) {
      model = HomeLayoutCubit.get(context).userModel;
    }
    return Builder(builder: (context) {
      HomeLayoutCubit.get(context).getUserPosts(userId: model!.uId!);

      var cubit = HomeLayoutCubit.get(context);

      return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    SizedBox(
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
                                    image: NetworkImage("${model!.cover}")),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).backgroundColor,
                            radius: 64.0,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage("${model!.image}"),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "${model!.name}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "${model!.bio}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "Posts",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  cubit.userPosts.length.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
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
                                  "Photo",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  "265",
                                  style: Theme.of(context).textTheme.subtitle1,
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
                                  "Friends",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  "10k",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          )),
                        ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    navigateTo(
                                        context: context,
                                        widget: UpdateProfileCreen());
                                  },
                                  child: const Text("Edit Profile"))),
                          const SizedBox(
                            width: 8.0,
                          ),
                          OutlinedButton(
                              onPressed: () {},
                              child: const Icon(
                                IconBroken.Image,
                                size: 16.0,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    cubit.userPosts.isEmpty
                        ? const Text("No Posts Yet !")
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.userPosts.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 8.0,
                                ),
                            itemBuilder: (context, index) =>
                                PostItem(postModel: cubit.userPosts[index])),
                    const SizedBox(
                      height: 5.0,
                    ),
                  ]))));
        }),
      );
    });
  }
}
