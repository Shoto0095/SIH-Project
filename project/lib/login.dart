import 'package:flutter/material.dart';

class Welogin extends StatefulWidget {
  const Welogin({super.key});

  @override
  State<Welogin> createState() => _WeloginState();
}

class _WeloginState extends State<Welogin> {
  final List<String> DepartmentOptions = [
    'Department 1',
    'Department 2',
    'Department 3',
    
  ];

  String? selectedPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assest/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.28,
                  left: 40,
                  right: 40, // Add right padding to center horizontally
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the elements horizontally
                  children: [
                    Column(
                      children: [
                        Text('Geo',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text('Attend',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage('assest/logo.png'),
                      radius: 30.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}