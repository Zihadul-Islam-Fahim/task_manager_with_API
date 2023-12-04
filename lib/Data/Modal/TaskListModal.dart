import 'Task.dart';

class TaskListModal {
  String? status;
  List<Task>? TaskList;

  TaskListModal({this.status, this.TaskList});

  TaskListModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      TaskList = <Task>[];
      json['data'].forEach((v) {
        TaskList!.add(Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.TaskList != null) {
      data['data'] = this.TaskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
