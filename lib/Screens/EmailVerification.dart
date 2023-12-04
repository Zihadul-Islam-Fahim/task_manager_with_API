import 'package:flutter/material.dart';
import 'package:task_manager_1/Controller/authController.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Data/utility/Validator.dart';
import 'package:task_manager_1/Screens/PinVerification.dart';
import 'package:task_manager_1/Widget/SnackBar.dart';
import 'package:task_manager_1/Widget/bodyBackground.dart';
import '../Data/utility/Url.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  Future<void> sendCodeToEmail() async {
    String? email = _emailController.text.trim();
    AuthController.saveEmailAndOtp('email', email);
    final NetworkResponse response =
        await NetworkCaller().getRequest1(Urls.verifyEmail, email);
    if (response.isSuccess) {
      if (mounted) {
        mySnackbar(context, 'OTP send to your Email');
        setState(() {
          loading = false;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PinVerification()));
      }
    } else {
      if (mounted) {
        mySnackbar(context, 'Error!! Try Again ', true);
        loading = false;
        setState(() {});
      }
    }
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
                    'Your Email Adress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'A 6 digit verification pin will send to your email address',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: validateEmail,
                    decoration: const InputDecoration(hintText: "Email"),
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
                            if (mounted) {
                              setState(() {
                                loading = true;
                                sendCodeToEmail();
                              });
                            }
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
  @override
  void dispose() {
   _emailController.dispose();
    super.dispose();
  }
}
