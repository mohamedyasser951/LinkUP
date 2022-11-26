import 'package:flutter/material.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
              separatorBuilder: (context, index) =>const SizedBox(height: 8.0,),
               itemBuilder: (context, index) => buildPostItem(context),),
          SizedBox(height: 300.0,),
        ],
      ),
    );
  }
}

Widget buildPostItem(BuildContext context) =>Card(
  margin: EdgeInsets.symmetric(horizontal: 8.0),
  clipBehavior: Clip.antiAlias,
  elevation: 5.0,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    "https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060&t=st=1669253501~exp=1669254101~hmac=2e49622bc5c2dc445d3b7cb1a023d08ad7709fa6af328387719fff7a9345e32d"),
              ),
              const  SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:const [
                        Text(
                          "Mohamed Yasser",
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
                      "January 22, 2002 at 11:00 pm",
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
            "In literary theory, a text is any object that can be \"read\", whether this object is a work of literature, a street sign, an arrangement of buildings on a city block, or styles of clothing. It is a coherent set of signs that transmits some kind of informative message.",
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
                    height:20.0,
                    child: MaterialButton(padding: EdgeInsets.zero,minWidth: 20,onPressed: (){},child: Text("#Software",style:Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.blue,
                    )),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height:20.0,
                    child: MaterialButton(padding: EdgeInsets.zero,minWidth: 20,onPressed: (){},child: Text("#Software",style:Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.blue,
                    )),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height:20.0,
                    child: MaterialButton(padding: EdgeInsets.zero,minWidth: 20,onPressed: (){},child: Text("#Development Software",style:Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.blue,
                    )),),
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
                    height:20.0,
                    child: MaterialButton(padding: EdgeInsets.zero,minWidth: 20,onPressed: (){},child: Text("#Software",style:Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.blue,
                    )),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height:20.0,
                    child: MaterialButton(padding: EdgeInsets.zero,minWidth: 20,onPressed: (){},child: Text("#Software",style:Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.blue,
                    )),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height:20.0,
                    child: MaterialButton(padding: EdgeInsets.zero,minWidth: 20,onPressed: (){},child: Text("#Development Software",style:Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.blue,
                    )),),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 140,
            decoration:const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://img.freepik.com/free-photo/portrait-handsome-smiling-stylish-young-man-model-dressed-red-checkered-shirt-fashion-man-posing_158538-4914.jpg?w=740&t=st=1669339465~exp=1669340065~hmac=6ceb463ba998cabc707fdfe7c330b45898ed7820eef428b9a8b1e08a170965ea")),
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
                        "1200",
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
                        "76 comment",
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
                      const CircleAvatar(
                        radius: 14.0,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060&t=st=1669253501~exp=1669254101~hmac=2e49622bc5c2dc445d3b7cb1a023d08ad7709fa6af328387719fff7a9345e32d"),
                      ),
                      const SizedBox(width: 5,),
                      Text("Write a comment..",style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                  onTap: (){},
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



        ]
    ),
  ),
);
