import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
              "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        ),
        SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mohamed yasser",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 2,
            ),
            Text("Very Good!!"),
          ],
        ),
      ]),
    );
  }
}
