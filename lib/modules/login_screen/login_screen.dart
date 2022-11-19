import 'package:flutter/material.dart';

import 'package:socialapp/shared/componenet/component.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Welcome Back! Glad \nto see you again",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                CustomizedTextfield(
                  hintText: "Email",
                  myController: email,
                  isPassword: false,
                  ),
             
               CustomizedTextfield(
                  hintText: "Password",
                  myController: password,
                  isPassword: true,
                  ),
                 Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const ForgotPassword()));
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(
                          color: Color(0xff6A707C),
                          fontSize: 15,
                        )),
                  ),
                ),
              ),
               CustomizedButton(buttonText: "Login",buttonColor: Colors.black,textColor: Colors.white,onPressed: (){},)
                       ,Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.height * 0.15,
                      color: Colors.grey,
                    ),
                    const Text("Or Login with"),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.height * 0.18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.facebook,
                           // FontAwesomeIcons.facebookF,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        )),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.g_mobiledata
                         // FontAwesomeIcons.google,
                          // color: Colors.blue,
                        ),
                        onPressed: () async {
                       
                         
                        },
                      ),
                    ),
                    Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.apple
                            //FontAwesomeIcons.apple,
                            // color: Colors.blue,
                          ),
                          onPressed: () {},
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(48, 8, 8, 8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text("Don't have an account?",
                        style: TextStyle(
                          color: Color(0xff1E232C),
                          fontSize: 15,
                        )),
                    Text("  Register Now",
                        style: TextStyle(
                          color: Color(0xff35C2C1),
                          fontSize: 15,
                        )),
              ],
            ),
          ),
        ]),
      ),
    )));
  }
}
