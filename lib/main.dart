import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Business%20Logic/chats/chats_cubit.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/modules/Auth/login_screen/cubit/cubit.dart';
import 'package:socialapp/modules/Auth/login_screen/login_screen.dart';
import 'package:socialapp/modules/on_boarding/on_boarding.dart';
import 'package:socialapp/modules/Auth/register_screen/cubit/cubit.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/network/local/shared_helper.dart';

import 'shared/componenet/block_observer.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  customizedToast(
      message: "Handle background message", toastState: ToastState.SUCESS);
  // print(message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedHelper.init();

  var token = await FirebaseMessaging.instance.getToken();

  // print("token is ${token}");

  //foreground fcm
  FirebaseMessaging.onMessage.listen(((event) {
    customizedToast(message: "on message ", toastState: ToastState.SUCESS);

    // print("on message ${event.data}");
  }));
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    customizedToast(
        message: "On meessageOpenedApp", toastState: ToastState.SUCESS);

    // print("meessageOpenedApp ${event.data}");
  });

  //background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  uId = SharedHelper.getData("uId");
  var onBoarding = await SharedHelper.getData("onBoarding");

  Widget StartWidget;
  if (onBoarding != null) {
    if (uId != null) {
      StartWidget = HomeLayout();
    } else {
      StartWidget = LoginScreen();
    }
  } else {
    StartWidget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: StartWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeLayoutCubit()..getUserData()..getLikes()),
        BlocProvider(create: ((context) => CubitLogin())),
        BlocProvider(create: ((context) => CubitRegister())),
        BlocProvider(
          create: (context) => ChatsCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.indigo,
            primarySwatch: Colors.indigo,
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: primaryColor,
                    statusBarIconBrightness: Brightness.light),
                elevation: 0.0,
                iconTheme: const IconThemeData(color: Colors.black))),
        home: startWidget,
      ),
    );
  }
}
