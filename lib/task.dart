import 'package:flutter/material.dart';
import 'package:my_app1/timer.dart';

class Task extends StatelessWidget {
  final int hours;
  final int minutes;
  final String taskName;
  final String priority;
  final VoidCallback deleteTask;

  Task({
    required this.hours,
    required this.minutes,
    required this.taskName,
    required this.priority,
    required this.deleteTask,
    Key? key, // Accept a key as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue[100],
        ),
        child: ListTile(
          minVerticalPadding: 20,
          title: Text(taskName, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Duration: $hours:$minutes, Priority: $priority"),
          tileColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.delete_outlined),
            onPressed: deleteTask,
          ),
          trailing: Container(
            width: 80,
            height: 70,
            child: MyTimer(timeLeft: hours * 60 + minutes, taskName: taskName),
          ),
        ),
      ),
    );
  }
}
