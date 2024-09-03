import 'package:flutter/material.dart';

class Welogin extends StatefulWidget {
  const Welogin({super.key});

  @override
  State<Welogin> createState() => _WeloginState();
}

class _WeloginState extends State<Welogin> {
    // Add more password options here
  ];


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
              const Padding(
                padding: EdgeInsets.only(top: 150, left: 40, right: 0),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assest/logo.png'),
                      radius: 50.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter User Name',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle dropdown value change
                    setState(() {
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Screen2');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Continue as Guest button click
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Continue as Guest',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
