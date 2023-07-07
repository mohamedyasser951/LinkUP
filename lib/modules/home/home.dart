import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/modules/comment_page/comment_page.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostsBuilder(),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}

class PostsBuilder extends StatefulWidget {
  const PostsBuilder({
    super.key,
  });

  @override
  State<PostsBuilder> createState() => _PostsBuilderState();
}

class _PostsBuilderState extends State<PostsBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<HomeLayoutCubit>(context).getPosts(),
        key: widget.key,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8.0,
            ),
            itemBuilder: (context, index) =>
                buildPostItem(index, snapshot.data!.docs[index], context),
          );
        });
  }
}

Widget buildPostItem(int index, var data, BuildContext context) {
  var cubit = HomeLayoutCubit.get(context);
  return BlocBuilder<HomeLayoutCubit, HomeLayoutStates>(
    builder: (context, state) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAlias,
        elevation: 12.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      "${data['image']}",
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
                            "${data['name']}",
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
                        "${data['dateTime']}",
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
                "${data['text']}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            if (data['postImage'] != '')
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${data['postImage']}")),
                ),
              ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      cubit.likePost(
                          posId: HomeLayoutCubit.get(context).postsId[index]);
                    },
                    child: InkWell(
                      onTap: () {
                        cubit.likedByMe(
                            postId:
                                HomeLayoutCubit.get(context).postsId[index]);
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
    },
  );
}
