import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

import 'comment_item.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text("Comments"),
            actions: [
              TextButton(onPressed: () {}, child: const Text("Post")),
              const SizedBox(
                width: 4.0,
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemBuilder: ((context, index) => const CommentItem()),
                      itemCount: 5)),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: commentController,
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
                      hintText: "write a comment",
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(IconBroken.Camera)),
                    ),
                  )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
