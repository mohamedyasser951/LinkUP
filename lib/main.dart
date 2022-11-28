
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/modules/login_screen/cubit/cubit.dart';
import 'package:socialapp/modules/login_screen/login_screen.dart';
import 'package:socialapp/modules/register_screen/cubit/cubit.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:socialapp/shared/network/local/shared_helper.dart';
import 'package:socialapp/shared/style/theme.dart';

import 'shared/componenet/block_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  await SharedHelper.init();
  Widget StartWidget;

  uId = SharedHelper.getData("uId") ;
  print("uid is ${uId}");
  if (uId != null) {
    StartWidget = HomeLayout();
  } else {
    StartWidget = LoginScreen();
  }
  BlocOverrides.runZoned(
    blocObserver: MyBlocObserver(),
    () => runApp(MyApp(
      startWidget: StartWidget,
    )),
  );
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
            ..getUserData(uId: "PdVyScRLPKO466jzMCWKt9NMSzQ2"),
        ),
        BlocProvider(create: ((context) => CubitLogin())),
        BlocProvider(create: ((context) => CubitRegister())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Themes.lightTheme,
        home: startWidget,
      ),
    );
  }
}
