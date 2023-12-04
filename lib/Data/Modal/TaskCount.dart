class TaskCount {
  TaskCount({
    String? id,
    num? sum,
  }) {
    _id = id;
    _sum = sum;
  }

  TaskCount.fromJson(dynamic json) {
    _id = json['_id'];
    _sum = json['sum'];
  }

  String? _id;
  num? _sum;

  TaskCount copyWith({
    String? id,
    num? sum,
  }) =>
      TaskCount(
        id: id ?? _id,
        sum: sum ?? _sum,
      );

  String? get id => _id;

  num? get sum => _sum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['sum'] = _sum;
    return map;
  }
}
