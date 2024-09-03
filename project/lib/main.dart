import 'package:flutter/material.dart';
import 'package:project/Screen2.dart';
import 'package:project/UserHomePage.dart';
import 'package:project/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    home: Welogin(),
    routes: {
      'login': (context) => const Welogin(),
      'Screen2': (context) => const Screen2(),
      'UserHomePage': (context) => const UserHomePage(),
    },
  ));
}
