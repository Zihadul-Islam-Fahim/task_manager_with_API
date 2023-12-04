import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_1/Controller/authController.dart';
import 'package:task_manager_1/Screens/TaskScreens/BottomSheetScreen.dart';
import 'package:task_manager_1/Widget/bodyBackground.dart';
import 'LogInScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> goToLoginScreen() async {
    final bool isLoggedIn = await AuthController.checkAuthState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isLoggedIn ? const BottomBar_Screen() : const LogInScreen()),
          (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    goToLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bodyBackground(
            child: Center(
              child: SvgPicture.asset('asset/images/logo.svg'),
            ),
          )
        ],
      ),
    );
  }
}
