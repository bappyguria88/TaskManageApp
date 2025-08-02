import 'package:flutter/material.dart';
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
        onDestinationSelected: (int index){
          _selectedIndex = index;

          setState(() {

          });
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
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewTaskScreens()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


