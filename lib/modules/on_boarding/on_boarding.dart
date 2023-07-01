import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socialapp/modules/Auth/login_screen/login_screen.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/network/local/shared_helper.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;

  OnBoardingModel(this.image, this.title, this.subTitle);
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boardingData = [
    OnBoardingModel(
        "assets/images/slider_1.png", "Share your Thought", "subTitle"),
    OnBoardingModel("assets/images/slider_2.png", "Easy to Use !", "subTitle"),
    OnBoardingModel(
        "assets/images/slider_3.png", "Connect with Others", "subTitle")
  ];
  PageController pageController = PageController();
  bool isLast = false;

  void submitStateOfOnBoarding() async {
    SharedHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value) {
        navigateAndFinish(context: context, widget: LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
           TextButton(
                  onPressed: () {
                    submitStateOfOnBoarding();
                  },
                  child: const Text("Skip")),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         
          Expanded(
            child: PageView.builder(
                onPageChanged: (value) {
                  if (value == boardingData.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                controller: pageController,
                itemBuilder: ((context, index) =>
                    buildOnBoardingItem(model: boardingData[index]))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: boardingData.length,
                  effect:  WormEffect(
                    activeDotColor:primaryColor,
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    spacing: 6.0,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (isLast) {
                      submitStateOfOnBoarding();
                    } else {
                      pageController.nextPage(
                          duration:const Duration(microseconds: 100),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Text("Next"))
            ],
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}

buildOnBoardingItem({required OnBoardingModel model}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Spacer(),
      Image(
        image: AssetImage(
          model.image,
        ),
        width: 280,
        height: 250,
      ),
      const SizedBox(
        height: 40.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Text(
        model.subTitle,
        style: const TextStyle(color: Colors.grey),
      ),
      const Spacer(),
    ],
  );
}
