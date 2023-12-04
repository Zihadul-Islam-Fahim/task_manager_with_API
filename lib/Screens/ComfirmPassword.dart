import 'package:flutter/material.dart';
import 'package:task_manager_1/Controller/authController.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Screens/LogInScreen.dart';
import 'package:task_manager_1/Widget/SnackBar.dart';
import 'package:task_manager_1/Widget/bodyBackground.dart';
import '../Data/utility/Url.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  bool loading = false;
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController cPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  setPassword(password) async {
    String email = await AuthController.retrieveEmailAndOtp('email');
    String otp = await AuthController.retrieveEmailAndOtp('OTP');

    var response = await NetworkCaller().postRequest(Urls.setPassword,
        body: {"email": email, "OTP": otp, "password": password.toString()});
    if (response.isSuccess && mounted) {
      mySnackbar(context, 'Password Changed,Please Login !!');
      setState(() {
        loading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LogInScreen()));
    } else if (mounted) {
      mySnackbar(context, 'Password Change failed,Try again !!', true);
      setState(() {
        loading = false;
      });
    } else {}
  }

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
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: passwordTEController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return ' Enter Password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "New Password"),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: cPasswordTEController,
                    validator: (String? value) {
                      if (value != passwordTEController.text) {
                        return 'Password should be same..';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(hintText: "Confirm Password"),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Visibility(
                    visible: loading == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            setPassword(cPasswordTEController.text);
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
