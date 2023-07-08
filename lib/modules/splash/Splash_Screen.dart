import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  final Widget startWidget;
  const SplashScreen({super.key,required this.startWidget});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("assets/images/icon.png",),
      nextScreen: widget.startWidget,
      duration: 4,
      splashIconSize: 70,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
