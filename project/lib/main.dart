import 'package:flutter/material.dart';
import 'package:project/Screen2.dart';
import 'package:project/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => Welogin(),
    },
  ));
}
