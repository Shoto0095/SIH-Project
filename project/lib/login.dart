import 'package:flutter/material.dart';

class Welogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assest/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.28,
                  left: 40,
                  right: 0,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20), // Add left padding here
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assest/logo.png'),
                      radius: 30.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
