import 'package:flutter/material.dart';
import 'package:my_app1/task.dart';
import 'package:my_app1/add_new_task.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AllTasks()));
}

class AllTasks extends StatefulWidget {
  const AllTasks({super.key});

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  List<String> tasks = ["task1", "task2"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, builder) {
                  return Task();
                }),
          )),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddNewTask(),
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
