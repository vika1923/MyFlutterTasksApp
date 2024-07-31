import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app1/task.dart';
import 'package:my_app1/add_new_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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

class _AllTasksState extends State<AllTasks> with WidgetsBindingObserver {
  List<List<dynamic>> tasks = [];
  bool noTimerIsRunning = true;
  int? lastCountingTimerIndex;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadTasks();
    WidgetsBinding.instance.addObserver(this);
    _loadPreferences();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();

    String dateTimeStr = prefs.getStringList("lastTimer")![1];
    int? lastTimerIndex = int.tryParse(prefs.getStringList("lastTimer")![0]);

    Duration difference = DateTime.now().difference(DateTime.parse(dateTimeStr));

    // TO DO
    print(lastTimerIndex);
    print(difference.inSeconds);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    // if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      await prefs.setStringList("lastTimer", [lastCountingTimerIndex.toString(), DateTime.now().toString()]);
    // }
  }

  void loadTasks() {
    var box = Hive.box('tasksBox');
    setState(() {
      tasks = box.values.toList().cast<List<dynamic>>();
    });
  }

  void deleteTask(int index) {
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
  }

  void updateNoTimerIsRunning(bool isRunning, index) {
    if (isRunning == false){
      lastCountingTimerIndex = index;
    } else {
      lastCountingTimerIndex = null;
    }
    setState(() {
      noTimerIsRunning = isRunning;
    });
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
                  switchTimerRunning: updateNoTimerIsRunning,
                  noTimerIsRunning: noTimerIsRunning,
                  index: index,
                  lastCountingTimerIndex: lastCountingTimerIndex,
                  key: ValueKey(tasks[index]),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddNewTask(),
              ).then((_) {
                loadTasks();
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
