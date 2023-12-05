import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_1/Data/Modal/UserModel.dart';

class AuthController {
  static String? token;
  static UserModel? user;


  static Future<void> saveUserInformation(String t, UserModel model) async {

    model = _checkUserPhoto(model);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', t);
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));

    token = t;
    user = model;
  }

  static Future<void> updateUserInformation( UserModel model) async {
    model = _checkUserPhoto(model);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));
    user = model;
  }

  static Future<void> saveEmailAndOtp(String? name, String? value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(name.toString(), value.toString());
  }

  static Future<String> retrieveEmailAndOtp(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? v = sharedPreferences.getString(name.toString());
    return v ?? '';
  }

  static Future<void> initializedUserCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    user = UserModel.fromJson(
        jsonDecode(sharedPreferences.getString('user') ?? '{}'));
  }

  static Future<bool> checkAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token != null) {
      await initializedUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
  }

 static UserModel _checkUserPhoto(UserModel model){
    if (model.photo != null && model.photo!.startsWith('data:image')) {
     //remove prefix
      model.updatePhoto( model.photo!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '')) ;

    }
    return model;
  }

}

