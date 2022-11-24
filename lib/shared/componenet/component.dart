import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  final bool? isPassword;
  final Function? suffixPressed;
  final IconData? suffixIcon;
  const CustomizedTextfield(
      {Key? key,
      required this.myController,
      this.hintText,
      this.isPassword,
      this.suffixIcon,
      this.suffixPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: isPassword!
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        enableSuggestions: isPassword! ? false : true,
        autocorrect: isPassword! ? false : true,
        obscureText: isPassword ?? true,
        controller: myController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(suffixIcon, color: Colors.grey),
            onPressed: () {
              suffixPressed!();
            },
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
              borderRadius: BorderRadius.circular(10)),
          fillColor: const Color(0xffE8ECF4),
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
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
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: buttonColor,
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
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
