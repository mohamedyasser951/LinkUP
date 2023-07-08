import 'package:flutter/material.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/modules/comment_page/comment_page.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class PostItem extends StatelessWidget {
  final PostModel postModel;
  const PostItem({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      clipBehavior: Clip.antiAlias,
      elevation: 12.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                  postModel.image!,
                  )),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          postModel.name!,
                          style: const TextStyle(height: 1.4),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                    Text(
                      postModel.dateTime!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 22,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              postModel.text!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          if (postModel.postImage != '')
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(postModel.postImage!)),
              ),
            ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                   
                  },
                  child: InkWell(
                    onTap: () {
                  
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 20,
                          // color: cubit.likedByMe(
                          //         postId: HomeLayoutCubit.get(context)
                          //             .postsId[index])
                          //     ? Colors.red
                          //     : Colors.black54,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "0".toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    navigateTo(context: context, widget: CommentScreen());
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.comment_outlined,
                        size: 20,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "0 comment",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
