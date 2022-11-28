import 'package:flutter/material.dart';

import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomizedAppBar(
            context: context,
            title: "Create Post",
            actions: [TextButton(onPressed: () {}, child: const Text("Post"))]),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060&t=st=1669253501~exp=1669254101~hmac=2e49622bc5c2dc445d3b7cb1a023d08ad7709fa6af328387719fff7a9345e32d"),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "Mohamed Yasser",
                    style: TextStyle(height: 1.4),
                  ),
                ],
              ),
              Expanded(
                  child: TextFormField(
                    controller: textController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "What is on your mind....",
                  border: InputBorder.none,
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: () {},
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
            ])));
  }
}
