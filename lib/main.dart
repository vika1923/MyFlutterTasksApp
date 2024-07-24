import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app1/task.dart';
import 'package:my_app1/add_new_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tasksBox');

  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: AllTasks()));
}

class AllTasks extends StatefulWidget {
  const AllTasks({super.key});

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  List<List<dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() {
  try {
    var box = Hive.box('tasksBox');
    setState(() {
      tasks = box.values.toList().cast<List<dynamic>>();
    });
  } catch (e) {
    print("Error loading tasks: $e");
  }
}

void deleteTask(int index){
  var box = Hive.box('tasksBox');
  setState(() {
    tasks.removeAt(index);
    box.deleteAt(index);
  });
}

void deleteBox() async {
    var box = await Hive.openBox('tasksBox');
    await box.deleteFromDisk();
    setState(() {
      tasks = [];
    });
    print("Box deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Task(
                  taskName: tasks[index][0],
                  hours: tasks[index][1],
                  minutes: tasks[index][2],
                  priority: tasks[index][3],
                  deleteTask: () => deleteTask(index),
                  key: ValueKey(tasks[index]),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              // deleteBox();
              showDialog(
                context: context,
                builder: (context) => AddNewTask(),
              ).then((_) {
                loadTasks();
              });
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
