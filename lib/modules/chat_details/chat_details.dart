import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Business%20Logic/chats/chats_cubit.dart';
import 'package:socialapp/Business%20Logic/chats/chats_states.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  ChatDetails({super.key, required this.userModel});

  final TextEditingController messageController = TextEditingController();
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatsCubit, ChatsStates>(
        listener: (context, state) {
          if (state is SendMessageSuccessState) {
            messageController.text = "";
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ChatBar(userModel: userModel)),
          body: ChatBody(
              userModel: userModel, messageController: messageController),
        ));
  }
}

class ChatBar extends StatelessWidget {
  const ChatBar({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 1,
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith())),
          ],
        ));
  }
}

class ChatBody extends StatelessWidget {
  ChatBody({
    super.key,
    required this.userModel,
    required this.messageController,
  });

  final UserModel userModel;
  final TextEditingController messageController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ChatsCubit>(context);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: cubit.getMessages(recieverId: userModel.uId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.separated(
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          if (uId == data["reciverId"]) {
                            return buildChatItem(data: data);
                          }

                          return buildMyChatItem(data: data);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12.0,
                        ),
                        itemCount: snapshot.data!.docs.length,
                      );
                    })),
            const SizedBox(
              height: 15.0,
            ),
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
                        onPressed: () {
                          cubit.pickImageMessage();
                        },
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
                        if (messageController.text.isNotEmpty) {
                          cubit.sendMessage(
                              recieverId: userModel.uId,
                              text: messageController.text,
                              dateTime: DateTime.now().toString());
                        } else if (cubit.imageMessage != null) {
                          cubit.sendChatImages(
                              imgFile: cubit.imageMessage!,
                              recieverId: userModel.uId!);
                        }
                      },
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget chatImg({required dynamic data}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    width: 200,
    height: 300,
    decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          bottomStart: Radius.circular(10),
        ),
        image: data != null
            ? DecorationImage(
                image: NetworkImage(
                  data["chatImg"],
                ),
                fit: BoxFit.cover)
            : null),
  );
}

Widget buildChatItem({required dynamic data}) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: data["text"] == null
        ? chatImg(data: data)
        : Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              ),
            ),
            child: Text("${data["text"]}"),
          ));

Widget buildMyChatItem({required dynamic data}) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: data["text"] == null
          ? chatImg(data: data)
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                  topStart: Radius.circular(10),
                ),
              ),
              child: Text(
                "${data["text"]}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
    );
