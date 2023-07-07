import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';

import '../../shared/style/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (val) {
              HomeLayoutCubit.get(context).search(searchText: val);
            },
            validator: (val) {
              if (val!.isNotEmpty) return "";
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 14),
              fillColor: Colors.black12,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xffE8ECF4), width: 1),
                  borderRadius: BorderRadius.circular(12.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xffE8ECF4), width: 1),
                  borderRadius: BorderRadius.circular(12.0)),
              prefixIcon: IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Search)),
              hintText: "Search",
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<HomeLayoutCubit, HomeLayoutStates>(
              builder: (context, state) {
            if (state is SearchLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchSuceessState) {
              if (state.users.isEmpty) {
                return const Center(
                  child: Text("Oops!...Not found"),
                );
              } else {
                return Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 28.0,
                                  backgroundImage:
                                      NetworkImage(state.users[index]["image"]),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(state.users[index]["name"]),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      state.users[index]["bio"],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 12,
                              ),
                          itemCount: state.users.length))
                ]);
              }
            } else {
              return const Center(
                child: Text(
                  "Try search for People",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          }),
        )
      ]),
    ));
  }
}
