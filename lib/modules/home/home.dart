import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.posts.length > 0, 
            builder: (context) {
             return  SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(8.0),
            elevation: 5.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const Image(
                    height: 200,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    image: NetworkImage(
                        "https://img.freepik.com/free-photo/positive-european-male-model-points-right-with-both-index-fingers-suggets-try-use-product-turns-aside_273609-38445.jpg?size=626&ext=jpg")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Communicate with Friends",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cubit.posts.length,
              separatorBuilder: (context, index) =>const SizedBox(height: 8.0,),
               itemBuilder: (context, index) => buildPostItem(cubit.posts[index],context),),
          SizedBox(height: 300.0,),
        ],
      ),
    );
            }, fallback:((context) =>  const Center(child: CircularProgressIndicator(),)));
      },
    );
  }
}

Widget buildPostItem(PostModel model,BuildContext context) => Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
               CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    "${model.image}",)),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:  [
                        Text(
                          "${model.name}",
                          style: TextStyle(height: 1.4),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    Text(
                      "${model.dateTime}",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          Text(
            "${model.text}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Container(
            width: double.infinity,
            // height: 40.0,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 20.0,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 20,
                      onPressed: () {},
                      child: Text("#Software",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue,
                              )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 20.0,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 20,
                      onPressed: () {},
                      child: Text("#Software",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue,
                              )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 20.0,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 20,
                      onPressed: () {},
                      child: Text("#Development Software",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue,
                              )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            // height: 40.0,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 20.0,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 20,
                      onPressed: () {},
                      child: Text("#Software",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue,
                              )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 20.0,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 20,
                      onPressed: () {},
                      child: Text("#Software",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue,
                              )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 20.0,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 20,
                      onPressed: () {},
                      child: Text("#Development Software",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue,
                              )),
                    ),
                  ),
                ),
              ],
            ),
          ),
         
         if(model.postImage != '')
          Container(
            height: 140,
            decoration:  BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "${model.postImage}")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "0",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Chat,
                        color: Colors.amber,
                        size: 18,
                      ),
                      SizedBox(
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                       CircleAvatar(
                        radius: 14.0,
                        backgroundImage: NetworkImage(
                            "${HomeLayoutCubit.get(context).userModel.image}"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Write a comment..",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Like",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
