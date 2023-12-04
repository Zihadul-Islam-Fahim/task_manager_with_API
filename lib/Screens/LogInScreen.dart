import 'package:flutter/material.dart';
import 'package:task_manager_1/Controller/authController.dart';
import 'package:task_manager_1/Data/Modal/UserModel.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Screens/EmailVerification.dart';
import 'package:task_manager_1/Widget/SnackBar.dart';
import 'package:task_manager_1/Widget/bodyBackground.dart';
import '../Data/networkCaller/NetworkCaller.dart';
import '../Data/utility/Url.dart';
import '../Data/utility/Validator.dart';
import 'RegScreen.dart';
import 'TaskScreens/BottomSheetScreen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Learn With Zihadul Islam',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Password!';
                      }
                      return null;
                    },
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Visibility(
                    visible: loading == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: () {

                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EmailVerification()));
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.grey),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegScreen()));
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future<void> login() async {
    loading = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login,
        body: {
          'email': _emailTEController.text.trim(),
          'password': _passwordTEController.text
        },
        isLogin: true);
    loading = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      await AuthController.saveUserInformation(response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      if (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BottomBar_Screen()));
      }
    }
    else {
      if (mounted && response.statusCode == 401) {
        mySnackbar(context, 'Email or Password incorrect!', true);
      } else {
        if (mounted) {
          mySnackbar(context, 'Log in Failed,try again', true);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
