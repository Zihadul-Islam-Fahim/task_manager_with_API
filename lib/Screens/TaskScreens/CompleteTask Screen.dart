import 'package:flutter/material.dart';
import '../../Data/Modal/TaskListModal.dart';
import '../../Data/networkCaller/NetworkCaller.dart';
import '../../Data/networkCaller/NetworkResponse.dart';
import '../../Data/utility/Url.dart';
import '../../Widget/ProfileSummaryCard.dart';
import '../../Widget/TaskCard.dart';
import '../../Widget/bodyBackground.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool loading = false;
  TaskListModal taskListModal = TaskListModal();

  Future<void> getCompleteTaskList() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTask);
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
    getCompleteTaskList();
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
                  onRefresh: getCompleteTaskList,
                  child: ListView.builder(
                      itemCount: taskListModal.TaskList?.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          task: taskListModal.TaskList![index],
                          chipColor: Colors.green,
                          refresh: getCompleteTaskList,
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
