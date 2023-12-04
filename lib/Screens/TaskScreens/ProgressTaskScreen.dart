import 'package:flutter/material.dart';
import '../../Data/Modal/TaskListModal.dart';
import '../../Data/networkCaller/NetworkCaller.dart';
import '../../Data/networkCaller/NetworkResponse.dart';
import '../../Data/utility/Url.dart';
import '../../Widget/ProfileSummaryCard.dart';
import '../../Widget/TaskCard.dart';
import '../../Widget/bodyBackground.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool loading = false;
  TaskListModal taskListModal = TaskListModal();

  Future<void> getProgressTaskList() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTask);
    if (response.isSuccess) {
      taskListModal = TaskListModal.fromJson(response.jsonResponse);
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProgressTaskList();
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
              child: Visibility(
                visible: loading == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getProgressTaskList,
                  child: ListView.builder(
                      itemCount: taskListModal.TaskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          task: taskListModal.TaskList![index],
                          chipColor: Colors.purple,
                          refresh: getProgressTaskList,
                        );
                      }),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
