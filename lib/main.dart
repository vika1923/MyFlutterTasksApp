import 'package:flutter/material.dart';
import 'package:my_app1/task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final tasks = ['task1', 'task2', 'task3'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("test"),
        ),
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index){
            return Task();
          },
        ),
      ),
    );
  }
}
