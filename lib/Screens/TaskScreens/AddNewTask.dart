
import 'package:flutter/material.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Screens/TaskScreens/BottomSheetScreen.dart';
import 'package:task_manager_1/Widget/ProfileSummaryCard.dart';
import 'package:task_manager_1/Widget/SnackBar.dart';

import '../../Data/utility/Url.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  bool loading = false;
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const ProfileSummeryCard(),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Add New Task',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _titleTEController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return ' Enter title';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: 'Title'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _descriptionTEController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return ' Enter Discription';
                          }
                          return null;
                        },
                        maxLines: 8,
                        decoration:
                            const InputDecoration(hintText: 'Description'),
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
                                createTask();
                              }
                            },
                            child: const Icon(Icons.arrow_forward_ios_rounded)),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTask() async {
    loading = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, body: {
      'title': _titleTEController.text.trim(),
      'description': _descriptionTEController.text.trim(),
      'status': 'New'
    });

    loading = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted) {
        mySnackbar(context, 'Task Created');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar_Screen()),
            (route) => false);
      }
    } else {
      if (mounted) {
        mySnackbar(context, 'Task Creating Failed!!,try again!', true);
      }
    }
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _titleTEController.dispose();
    super.dispose();
  }
}
