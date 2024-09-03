import 'package:flutter/material.dart';
import 'package:project/UserHomePage.dart';
import 'package:project/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => const Welogin(),
    },
  ));
}

