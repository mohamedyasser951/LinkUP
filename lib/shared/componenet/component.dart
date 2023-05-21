import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/modules/Auth/login_screen/login_screen.dart';
import 'package:socialapp/shared/network/local/shared_helper.dart';
import 'package:socialapp/shared/style/icon_broken.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  final String? label;
  final bool? isPassword;
  final Function? suffixPressed;
  final String? Function(String? val) validator;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  const CustomizedTextfield(
      {Key? key,
      required this.myController,
      this.hintText,
      this.isPassword,
      this.suffixIcon,
      this.suffixPressed,
      required this.validator,
      this.prefixIcon,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextFormField(
        validator: validator,
        controller: myController,
        keyboardType: isPassword!
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        enableSuggestions: isPassword! ? false : true,
        autocorrect: isPassword! ? false : true,
        obscureText: isPassword ?? true,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon, color: Colors.grey),
                    onPressed: () {
                      suffixPressed!();
                    },
                  )
                : null,
            // enabledBorder: OutlineInputBorder(
            //     borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
            //     borderRadius: BorderRadius.circular(10)),
            // focusedBorder: OutlineInputBorder(
            //     borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
            //     borderRadius: BorderRadius.circular(10)),
            // fillColor: const Color(0xffE8ECF4),
            // filled: true,
            hintText: hintText,
            border: const UnderlineInputBorder()),
      ),
    );
  }
}

class CustomizedButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  const CustomizedButton(
      {Key? key,
      this.buttonText,
      this.buttonColor,
      this.onPressed,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: buttonColor,
                //border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(8.0)),
            child: Center(
                child: Text(
              buttonText!,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ))),
      ),
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  final String asset;
  final VoidCallback onTap;

  const AppOutlineButton({super.key, required this.asset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          asset,
          height: 24,
        ),
      ),
    );
  }
}

navigateTo({required BuildContext context, required Widget widget}) {
  Navigator.of(context).push(MaterialPageRoute(builder: ((context) => widget)));
}

navigateAndFinish({required BuildContext context, required Widget widget}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) {
      return false;
    },
  );
}

// ignore: constant_identifier_names
enum ToastState { SUCESS, WORNING, Error }

customizedToast({required String message, required ToastState toastState}) {
  Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      backgroundColor: changeToastColor(state: toastState),
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
      fontSize: 16.0);
}

changeToastColor({required ToastState state}) {
  Color toastColor;
  switch (state) {
    case ToastState.SUCESS:
      toastColor = Colors.green;
      break;
    case ToastState.WORNING:
      toastColor = Colors.amber;
      break;
    case ToastState.Error:
      toastColor = Colors.red;
      break;
  }
  return toastColor;
}

PreferredSizeWidget CustomizedAppBar(
        {required BuildContext context,
        required String title,
        List<Widget>? actions}) =>
    AppBar(
      titleSpacing: 1,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      actions: actions,
      leading: IconButton(
        icon: const Icon(IconBroken.Arrow___Left_2),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );

void logOut(BuildContext context) {
  SharedHelper.removeData(key: "uId").then((value) {
    if (value) {
      navigateAndFinish(context: context, widget: LoginScreen());
    }
  });
}
