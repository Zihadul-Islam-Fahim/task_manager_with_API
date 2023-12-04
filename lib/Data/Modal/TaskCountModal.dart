import 'TaskCount.dart';

class TaskCountModal {
  TaskCountModal({
    String? status,
    List<TaskCount>? countList,
  }) {
    _status = status;
    _countList = countList;
  }

  TaskCountModal.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _countList = [];
      json['data'].forEach((v) {
        _countList?.add(TaskCount.fromJson(v));
      });
    }
  }

  String? _status;
  List<TaskCount>? _countList;

  TaskCountModal copyWith({
    String? status,
    List<TaskCount>? data,
  }) =>
      TaskCountModal(
        status: status ?? _status,
        countList: data ?? _countList,
      );

  String? get status => _status;

  List<TaskCount>? get taskCount => _countList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_countList != null) {
      map['data'] = _countList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
