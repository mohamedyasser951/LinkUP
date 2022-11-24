import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.all(8.0),
            elevation: 10.0,
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
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            clipBehavior: Clip.antiAlias,
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060&t=st=1669253501~exp=1669254101~hmac=2e49622bc5c2dc445d3b7cb1a023d08ad7709fa6af328387719fff7a9345e32d"),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Mohamed Yasser",
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
                            style: Theme.of(context).textTheme.caption,
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
                )
                ,Text("In literary theory, a text is any object that can be \"read\", whether this object is a work of literature, a street sign, an arrangement of buildings on a city block, or styles of clothing. It is a coherent set of signs that transmits some kind of informative message.")
             
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
