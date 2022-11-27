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
        var model = HomeLayoutCubit.get(context).userModel;
        return Scaffold(
          appBar: CustomizedAppBar(
              context: context,
              title: "Edit Profile",
              actions: [
                TextButton(onPressed: () {}, child: const Text("Update")),
                const SizedBox(
                  width: 10.0,
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150.0,
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "${model.cover}")),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: CircleAvatar(
                                    child: Icon(IconBroken.Camera),
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
                              child:  CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(
                                    "${model.image}"),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                  child: Icon(IconBroken.Camera),
                                ))
                          ],
                        ),
                      ],
                    ),
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
                      myController: nameController,
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
                      myController: nameController,
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
