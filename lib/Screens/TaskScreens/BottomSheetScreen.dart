import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_1/Screens/TaskScreens/CenceledTaskScreen.dart';
import 'package:task_manager_1/Screens/TaskScreens/CompleteTask%20Screen.dart';
import 'package:task_manager_1/Screens/TaskScreens/ProgressTaskScreen.dart';
import 'NewTaskScreen.dart';

class BottomBar_Screen extends StatefulWidget {
  const BottomBar_Screen({super.key});

  @override
  State<BottomBar_Screen> createState() => _BottomBar_ScreenState();
}

class _BottomBar_ScreenState extends State<BottomBar_Screen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompleteTaskScreen(),
    CenceledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_card), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.sort_up), label: "Progress"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline), label: "Completed"),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_done), label: "Canceled"),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
