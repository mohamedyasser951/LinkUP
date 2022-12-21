import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socialapp/main.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/componenet/constant.dart';

class SplashScreen extends StatefulWidget {
   
  
   SplashScreen({super.key,});
   
   

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      navigateAndFinish(context: context, widget: StartWidget);
    });
    super.initState();
  }

 
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              width: 150,
              image: AssetImage("assets/images/yupo-text.png"),
            ),
            SizedBox(
              height: 40.0,
            ),
            SpinKitThreeBounce(
              duration: Duration(microseconds: 1000000),
              color: Colors.white,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
