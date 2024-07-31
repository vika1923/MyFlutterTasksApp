import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hive/hive.dart';

class MyTimer extends StatefulWidget {
  final int timeLeft;
  final String taskName;
  final Function(bool, int) switchTimerRunning;
  final bool noTimerIsRunning;
  final int index;
  final int? lastCountingTimerIndex;

  const MyTimer(
      {super.key,
      required this.timeLeft,
      required this.taskName,
      required this.switchTimerRunning,
      required this.noTimerIsRunning,
      required this.index,
      required this.lastCountingTimerIndex});

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

    if (widget.index == widget.lastCountingTimerIndex) {
      startCountdown();
      setState(() {
        isNotRunning = false;
      });
    }
  }

  void startCountdown() {
    // print("start countdown function called");
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft -= 1;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void startOrStopCountdown() {
    // print("1");
    if (isNotRunning) {
      // print("2");
      if (widget.noTimerIsRunning) {
        // print("3");
        startCountdown();
        setState(() {
          isNotRunning = false;
          widget.switchTimerRunning(false, widget.index);
        });
      }
    } else {
      countdownTimer?.cancel();
      setState(() {
        isNotRunning = true;
        widget.switchTimerRunning(true, widget.index);
      });
    }
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    if (!isNotRunning) {
      setState(() {
        widget.switchTimerRunning(true, widget.index);
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
          onPressed: startOrStopCountdown,
        ),
        Text(timeLeft.toString()),
      ],
    );
  }
}
