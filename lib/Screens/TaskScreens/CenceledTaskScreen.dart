import 'package:flutter/material.dart';
import '../../Data/Modal/TaskListModal.dart';
import '../../Data/networkCaller/NetworkCaller.dart';
import '../../Data/networkCaller/NetworkResponse.dart';
import '../../Data/utility/Url.dart';
import '../../Widget/ProfileSummaryCard.dart';
import '../../Widget/TaskCard.dart';
import '../../Widget/bodyBackground.dart';

class CenceledTaskScreen extends StatefulWidget {
  const CenceledTaskScreen({super.key});

  @override
  State<CenceledTaskScreen> createState() => _CenceledTaskScreenState();
}

class _CenceledTaskScreenState extends State<CenceledTaskScreen> {
  bool loading = false;
  TaskListModal taskListModal = TaskListModal();

  Future<void> getCanceledTaskList() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCanceledTask);
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
    getCanceledTaskList();
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
                  onRefresh: getCanceledTaskList,
                  child: ListView.builder(
                      itemCount: taskListModal.TaskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          task: taskListModal.TaskList![index],
                          chipColor: Colors.red,
                          refresh: getCanceledTaskList,
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
