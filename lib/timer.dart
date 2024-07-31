import 'package:flutter/material.dart';
import 'dart:async';

class MyTimer extends StatefulWidget {
  final int timeLeft;
  final String taskName;
  final Function(bool) switchTimerRunning;
  final bool noTimerIsRunning;

  const MyTimer({
    super.key,
    required this.timeLeft,
    required this.taskName,
    required this.switchTimerRunning,
    required this.noTimerIsRunning
  });

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
    if(widget.noTimerIsRunning){
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
      widget.switchTimerRunning(false);
    });}
  } else {
    countdownTimer?.cancel();
    setState(() {
      isNotRunning = true;
      widget.switchTimerRunning(true);
    });
  }
}

  @override
  void dispose() {
    countdownTimer?.cancel();
    if(!isNotRunning){
      setState(() {
        widget.switchTimerRunning(true);
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(isNotRunning ? Icons.play_arrow : Icons.pause),
          onPressed: startCountdown,
        ),
        Text(timeLeft.toString()),
      ],
    );
  }
}
