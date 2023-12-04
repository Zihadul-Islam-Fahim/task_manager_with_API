class UserModel {
  UserModel({
    String? email,
    String? firstName,
    String? lastName,
    String? mobile,
    String? photo,
  }) {
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _mobile = mobile;
    _photo = photo;
  }

  UserModel.fromJson(dynamic json) {
    _email = json['email'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _mobile = json['mobile'];
    _photo = json['photo'];
  }

  String? _email;
  String? _firstName;
  String? _lastName;
  String? _mobile;
  String? _photo;

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? mobile,
    String? photo,
  }) =>
      UserModel(
        email: email ?? _email,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        mobile: mobile ?? _mobile,
        photo: photo ?? _photo,
      );

  String? get email => _email;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get mobile => _mobile;

  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['mobile'] = _mobile;
    map['photo'] = _photo;
    return map;
  }
}
