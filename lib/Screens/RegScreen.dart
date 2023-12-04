import 'package:flutter/material.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Data/utility/Url.dart';
import 'package:task_manager_1/Screens/LogInScreen.dart';
import 'package:task_manager_1/Widget/SnackBar.dart';
import 'package:task_manager_1/Widget/bodyBackground.dart';
import '../Data/utility/Validator.dart';

class RegScreen extends StatefulWidget {
  RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                        'Join With Us',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Email"),
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "First Name"),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Last Name"),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        controller: _mobileController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.length != 11) {
                            return "Mobile No must be 11 digit";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Mobile"),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your password';
                          } else if (value!.length < 6) {
                            return 'Password more than 6 letters';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Password"),
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
                            onPressed: () => signUp(),
                            child: const Icon(Icons.arrow_forward_ios_rounded)),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account? ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign in',
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

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.registration, body: {
        "email": _emailController.text.trim(),
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "mobile": _mobileController.text,
        "password": _passwordController.text,
      });

      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      if (response.isSuccess) {
        if (mounted) {
          ClearTextField();
          mySnackbar(context, 'Account has been created!');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LogInScreen()));
        }
      } else {
        if (mounted) {
          mySnackbar(context, 'Account creation failed!', true);
        }
      }
    }
  }

  void ClearTextField() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
