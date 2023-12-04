import 'package:flutter/material.dart';
import 'package:task_manager_1/Screens/SplashScreen.dart';

class TaskManagerApp extends StatelessWidget {
  TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      home: const SplashScreen(),
      theme: ThemeData(
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none)),
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(380, 45),
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))))),
    );
  }
}
