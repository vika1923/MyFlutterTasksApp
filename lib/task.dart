import 'package:flutter/material.dart';

class Task extends StatelessWidget{
  
  // final int hours ;
  // final int minutes ;
  // final String taskName ;

  // Task({required this.hours, required this.minutes, required this.taskName});

  @override
  Widget build(BuildContext context){
    return ListTile(
      minVerticalPadding: 20,
      title: const Text("Thing to do", style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: ClipRRect(
      borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 100,
          color: Colors.lightBlue[100],
        ),
       )
    );
  }
}
