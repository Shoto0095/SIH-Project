import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _WeSummarystate();
}

class _WeSummarystate extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assest/login.png'), fit: BoxFit.cover),
      ),
    );
    Column();
  }
}
