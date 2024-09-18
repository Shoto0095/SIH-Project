import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ManualAttendance extends StatefulWidget {
  const ManualAttendance({super.key});

  @override
  State<ManualAttendance> createState() => _ManualAttendanceState();
}

class _ManualAttendanceState extends State<ManualAttendance> {
  String _currentTime = '';
  bool _isCheckedIn = false;
  String _statusMessage = 'Swipe to check in';

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    _currentTime = _formatTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _formatTime(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(DateTime time) {
    return DateFormat('hh:mm:ss a').format(time);
  }

  void _handleCheckInOut() {
    setState(() {
      if (!_isCheckedIn) {
        _statusMessage = 'Checked in at $_currentTime';
      } else {
        _statusMessage = 'Checked out at $_currentTime';
      }
      _isCheckedIn = !_isCheckedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assest/login.png'), // Replace with your actual image path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assest/logo.png'), // Replace with your actual image path
                        radius: 50.0,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    _currentTime,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // White space to display check-in or check-out status
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _statusMessage,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Swipe Button using Slidable
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => _handleCheckInOut(),
                          backgroundColor:
                              _isCheckedIn ? Colors.red : Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.swipe,
                          label: _isCheckedIn
                              ? 'Swipe to check out'
                              : 'Swipe to check in',
                        ),
                      ],
                    ),
                    child: Container(
                      height: 60,
                      color: _isCheckedIn ? Colors.red : Colors.green,
                      child: Center(
                        child: Text(
                          _isCheckedIn
                              ? 'Swipe to check out'
                              : 'Swipe to check in',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
