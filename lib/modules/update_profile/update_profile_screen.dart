import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class UpdateProfileCreen extends StatelessWidget {
  UpdateProfileCreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        var cubit = HomeLayoutCubit.get(context);
        var model = HomeLayoutCubit.get(context).userModel;
        var profileImage = HomeLayoutCubit.get(context).profileImage;
        var coverImage = HomeLayoutCubit.get(context).coverImage;
        nameController.text = model!.name!;
        bioController.text = model.bio!;
        phoneController.text = model.phone!;
        return Scaffold(
          appBar: CustomizedAppBar(
              context: context,
              title: "Edit Profile",
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.updateUserData(
                          name: nameController.text,
                          bio: bioController.text,
                          phone: phoneController.text);
                    },
                    child: state is SocialUpdateUserDataLoadingState
                        ? const CupertinoActivityIndicator()
                        : const Icon(Icons.done)),
                const SizedBox(
                  width: 10.0,
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // if (state is SocialUpdateUserDataLoadingState)
                  //   const LinearProgressIndicator(),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage == null
                                        ? NetworkImage("${model.cover}")
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    HomeLayoutCubit.get(context)
                                        .getCoverImage();
                                  },
                                  icon:  CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child:const Icon(IconBroken.Camera),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              radius: 64.0,
                              child: CircleAvatar(
                                radius: 60.0,
                                
                                backgroundImage: profileImage == null
                                    ? NetworkImage("${model.image}")
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  HomeLayoutCubit.get(context)
                                      .getProfileImage();
                                },
                                icon:  CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(IconBroken.Camera),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (profileImage != null || coverImage != null)
                    const SizedBox(
                      height: 5.0,
                    ),
                  Row(
                    children: [
                      if (profileImage != null)
                        Expanded(
                            child: Column(
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  cubit.uploadProfileImag(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text);
                                },
                                child: Text("UpLoad profile")),
                            SizedBox(
                              height: 4.0,
                            ),
                            // if (state is SocialUpdateUserDataLoadingState)
                            //   const LinearProgressIndicator(),
                          ],
                        )),
                      if (coverImage != null)
                        Expanded(
                            child: Column(
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  cubit.uploadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text);
                                },
                                child:const Text("UpLoad cover")),
                            SizedBox(
                              height: 4.0,
                            ),
                            // if (state is SocialUpdateUserDataLoadingState)
                            //   const LinearProgressIndicator(),
                          ],
                        ))
                    ],
                  ),
                  CustomizedTextfield(
                      myController: nameController,
                      isPassword: false,
                      label: "Name",
                      validator: ((val) {
                        if (val!.isEmpty) {
                          return "name must be entered.!";
                        }
                        return null;
                      }),
                      prefixIcon: IconBroken.User),
                  CustomizedTextfield(
                      myController: bioController,
                      isPassword: false,
                      label: "Bio",
                      validator: ((val) {
                        if (val!.isEmpty) {
                          return "Bio must be entered.!";
                        }
                        return null;
                      }),
                      prefixIcon: IconBroken.Info_Circle),
                  CustomizedTextfield(
                      myController: phoneController,
                      isPassword: false,
                      label: "phone",
                      validator: ((val) {
                        if (val!.isEmpty) {
                          return "phone must be entered.!";
                        }
                        return null;
                      }),
                      prefixIcon: IconBroken.Call),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
