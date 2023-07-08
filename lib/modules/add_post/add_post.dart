import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';

import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: ((context, state) {
        if (state is SocialCreateNewPostSuccessState) {
          customizedToast(
              message: "Post Created SuccessFully",
              toastState: ToastState.SUCESS);
          Navigator.of(context).pop();
        }
      }),
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CustomizedAppBar(
                context: context,
                title: "Create Post",
                actions: [
                  TextButton(
                      onPressed: () {
                        if (textController.text != "" || cubit.postImage != null) {
                          if (cubit.postImage != null) {
                          cubit.uplaodPostImage(
                              postText: textController.text, dateTime: timenow);
                        } else {
                          cubit.createNewPost(
                              postText: textController.text, dateTime: timenow);
                        }
                        }
                      },
                      child: state is SocialCreateNewPostLoadingState
                          ? const CupertinoActivityIndicator()
                          : const Icon(Icons.done))
                ]),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    if (State is SocialCreateNewPostLoadingState)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(),
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage:
                              NetworkImage("${cubit.userModel!.image}"),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "${cubit.userModel!.name}",
                          style: const TextStyle(height: 1.4),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.4,
                      child: TextFormField(
                        controller: textController,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: "What is on your mind....",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (cubit.postImage != null)
                      Stack(alignment: Alignment.bottomCenter, children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 210.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(cubit.postImage!),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.removePostImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ]),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 4,
                              ),
                              Text("add Photo")
                            ],
                          ),
                        )),
                        Expanded(
                            child: TextButton(
                          onPressed: () {},
                          child: const Text("# tags"),
                        ))
                      ],
                    )
                  ])),
            ));
      },
    );
  }
}
