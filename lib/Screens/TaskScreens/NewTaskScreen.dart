import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_1/Data/Modal/TaskCountModal.dart';
import 'package:task_manager_1/Data/Modal/TaskListModal.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkCaller.dart';
import 'package:task_manager_1/Data/networkCaller/NetworkResponse.dart';
import 'package:task_manager_1/Data/utility/Url.dart';
import 'package:task_manager_1/Screens/TaskScreens/AddNewTask.dart';
import '../../Widget/ProfileSummaryCard.dart';
import '../../Widget/SummaryCard.dart';
import '../../Widget/TaskCard.dart';
import '../../Widget/bodyBackground.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool loading = false;
  bool countLoading = false;
  TaskListModal taskListModal = TaskListModal();
  TaskCountModal taskCountModal = TaskCountModal();

  Future<void> getNewTaskList() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);
    if (response.isSuccess) {
      taskListModal = TaskListModal.fromJson(response.jsonResponse);
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> getTaskCount() async {
    if (mounted) {
      setState(() {
        countLoading = true;
      });
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskCount);
    if (response.isSuccess) {
      taskCountModal = TaskCountModal.fromJson(response.jsonResponse);
    }
    if (mounted) {
      setState(() {
        countLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskCount();
    getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: bodyBackground(
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Visibility(
                            visible: countLoading == false &&
                                (taskCountModal.taskCount?.isNotEmpty ?? false),
                            replacement: const Center(
                              child: LinearProgressIndicator(),
                            ),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    taskCountModal.taskCount?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return SummaryCard(
                                      count:
                                          taskCountModal.taskCount![index].sum,
                                      title:
                                          taskCountModal.taskCount![index].id);
                                })),
                      ),
                    ),
                    Expanded(
                        flex: 90,
                        child: Visibility(
                          visible: loading == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: RefreshIndicator(
                            onRefresh: getNewTaskList,
                            child: ListView.builder(
                                itemCount: taskListModal.TaskList?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return TaskCard(
                                    task: taskListModal.TaskList![index],
                                    chipColor: Colors.blue,
                                    refresh: getNewTaskList,
                                    getTaskCount: getTaskCount,
                                  );
                                }),
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewTask()));
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
