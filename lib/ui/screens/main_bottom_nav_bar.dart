import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/ui/controllers/new_task_controller.dart';
import 'package:np/ui/controllers/task_status_count_controller.dart';
import 'package:np/ui/screens/progress_task_screen.dart';
import 'add_new_task_screens.dart';
import 'cancle_task_screen.dart';
import 'complete_task_screen.dart';
import 'new_task_screens.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreens(),
    ProgressTaskScreen(),
    CompleteTaskScreen(),
    CancelTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;

          setState(() {});
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(
              icon: Icon(Icons.incomplete_circle), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'cancel'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNewTaskScreens(
            refreshNewList: () {
              Get.find<NewTaskController>().getAllNewTaskList();
            },
            counRefershList: () {
              Get.find<TaskStatusCountController>().getAllTaskStatusCount();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
