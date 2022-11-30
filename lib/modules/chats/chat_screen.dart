import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0),
      child: ListView.separated(
        physics:const BouncingScrollPhysics(),
        itemBuilder: ((context, index) => buildChatItem()),
         separatorBuilder: (context, index) => Divider(),
          itemCount: 20,
      ),
    );
  }
}

Widget buildChatItem() {
  return InkWell(
    onTap: () {},
    child: Row(children: const [
      CircleAvatar(
        radius: 25.0,
        backgroundImage: NetworkImage(
            "https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060&t=st=1669253501~exp=1669254101~hmac=2e49622bc5c2dc445d3b7cb1a023d08ad7709fa6af328387719fff7a9345e32d"),
      ),
      SizedBox(
        width: 10.0,
      ),
      Text("Ahamed Yasser"),
    ]),
  );
}
