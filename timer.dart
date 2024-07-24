import 'package:flutter/material.dart';
import 'dart:async';

class MyTimer extends StatefulWidget {
  final int timeLeft;
  final String taskName;

  MyTimer({required this.timeLeft, required this.taskName});

  @override
  _MyTimerState createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  late int timeLeft;
  Timer? countdownTimer;
  bool isNotRunning = true;

  @override
  void initState() {
    super.initState();
    timeLeft = widget.timeLeft;
  }

  void startCountdown() {
    if (isNotRunning) {
      countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (timeLeft > 0) {
            timeLeft--;
          } else {
            timer.cancel();
          }
        });
      });
      setState(() {
        isNotRunning = false;
      });
    } else {
      countdownTimer?.cancel();
      setState(() {
        isNotRunning = true;
      });
    }
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: Icon(isNotRunning ? Icons.play_arrow : Icons.pause),
            onPressed: startCountdown,
          ),
          Text(timeLeft.toString()),
        ],
      ),
    );
  }
}
