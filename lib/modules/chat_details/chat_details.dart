import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ChatDetails({super.key, required this.userModel});
  var messageController = TextEditingController();

  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeLayoutCubit.get(context).getMessages(userModel.uId);

      return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {
          if (state is SocialSendMessageSuccessState) {
            messageController.text = "";
          }
        },
        builder: ((context, state) {
          var cubit = HomeLayoutCubit.get(context);

          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(IconBroken.Arrow___Left_2),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                titleSpacing: 0.0,
                actions: [
                  IconButton(
                    icon: const Icon(IconBroken.Video),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(IconBroken.Call),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage("${userModel.image}")),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Expanded(
                        child: Text("${userModel.name}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith())),
                  ],
                )),
            body: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message = cubit.messages[index];
                          if (cubit.userModel!.uId == message.reciverId)
                            return buildChatItem(message);
                          return buildMyChatItem(message);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12.0,
                        ),
                        itemCount: cubit.messages.length,
                      )),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: messageController,
                            validator: (val) {
                              if (val!.isNotEmpty) return "";
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1.0),
                                  borderRadius: BorderRadius.circular(40.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE8ECF4), width: 1),
                                  borderRadius: BorderRadius.circular(40.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE8ECF4), width: 1),
                                  borderRadius: BorderRadius.circular(40.0)),
                              prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.emoji_emotions,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
                              hintText: "Message",
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(IconBroken.Camera)),
                            ),
                          )),
                          const SizedBox(
                            width: 4.0,
                          ),
                          CircleAvatar(
                              radius: 22,
                              backgroundColor: primaryColor,
                              child: IconButton(
                                icon: const Icon(
                                  IconBroken.Send,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                //  if (formKey.currentState!.validate()) {
                                    cubit.sendMessage(
                                        recieverId: userModel.uId,
                                        text: messageController.text,
                                        dateTime: DateTime.now().toString());
                                 // }
                                },
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      );
    });
  }
}

Widget buildChatItem(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            bottomStart: Radius.circular(10),
          ),
        ),
        child: Text("${model.text}"),
      ),
    );

Widget buildMyChatItem(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        child: Text(
          "${model.text}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
