import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';

String? uId = FirebaseAuth.instance.currentUser!.uid;
final timenow = Jiffy(DateTime.now()).yMMMd;
Color primaryColor =const Color(0xFF3F51B5);
