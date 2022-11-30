import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: ((context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Left_2),
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
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060&t=st=1669253501~exp=1669254101~hmac=2e49622bc5c2dc445d3b7cb1a023d08ad7709fa6af328387719fff7a9345e32d"),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                      child: Text("Ahamed yasser",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith())),
                ],
              )),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(10),
                        topEnd: Radius.circular(10),
                        bottomStart: Radius.circular(10),
                      ),
                    ),
                    child: Text("Hello mohamed !"),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    padding:
                       const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                    decoration:const BoxDecoration(
                      color: Color.fromARGB(255, 169, 194, 215),
                      borderRadius:  BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(10),
                        bottomStart: Radius.circular(10),
                        topStart: Radius.circular(10),
                      ),
                    ),
                    child: Text("Hello yasser How are you !"),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
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
                          onPressed: () {
                          },
                        ),
                        hintText: "Message",
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(IconBroken.Camera)),
                      ),
                    )),
                    SizedBox(
                      width: 4.0,
                    ),
                    CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          icon: const Icon(
                            IconBroken.Send,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
