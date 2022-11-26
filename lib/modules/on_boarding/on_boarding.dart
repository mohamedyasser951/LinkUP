import 'package:flutter/material.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;

  OnBoardingModel(this.image, this.title, this.subTitle);
}

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({super.key});
  // List<OnBoardingModel> boardingData = [
  //   OnBoardingModel(image,"Share your Thought", subTitle),
  //   OnBoardingModel(image, "Stay connect with your friends", subTitle),
  //   OnBoardingModel(image, "Find More friends", subTitle)
 // ];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
