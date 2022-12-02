import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/modules/login_screen/cubit/cubit.dart';
import 'package:socialapp/modules/login_screen/login_screen.dart';
import 'package:socialapp/modules/register_screen/cubit/cubit.dart';
import 'package:socialapp/shared/componenet/component.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/network/local/shared_helper.dart';
import 'package:socialapp/shared/style/theme.dart';

import 'shared/componenet/block_observer.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  customizedToast(
      message: "Handle background message", toastState: ToastState.SUCESS);
  print(message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedHelper.init();

  var token = await FirebaseMessaging.instance.getToken();
  print("token is ${token}");

  //foreground fcm
  FirebaseMessaging.onMessage.listen(((event) {
    customizedToast(message: "on message ", toastState: ToastState.SUCESS);

    print("on message ${event.data}");
  }));
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    customizedToast(
        message: "On meessageOpenedApp", toastState: ToastState.SUCESS);

         print("meessageOpenedApp ${event.data}");
  });

  //background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  uId = SharedHelper.getData("uId");

  Widget StartWidget;

  if (uId != null) {
    StartWidget = HomeLayout();
  } else {
    StartWidget = LoginScreen();
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
        BlocProvider(
          create: (context) => HomeLayoutCubit()
            ..getUserData(uId: uId)
            ..getPosts(),
        ),
        BlocProvider(create: ((context) => CubitLogin())),
        BlocProvider(create: ((context) => CubitRegister())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        home: startWidget,
      ),
    );
  }
}
