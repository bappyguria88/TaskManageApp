import 'dart:convert';

import 'package:np/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthControllers {
  static String? token;
  static UserModel? userModel;

  static const String _tokenKey = 'token';
  static const String _userModelKey = 'user-data';

  static Future<void> saveUserInformation(
      String accessToken, UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(_userModelKey, jsonEncode(user.toJson()));

    token = accessToken;
    userModel = user;
  }

  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? saveUserModelString = sharedPreferences.getString(_userModelKey);

    if (saveUserModelString != null) {
      UserModel saveUserModel =
          UserModel.fromJson(jsonDecode(saveUserModelString));

      userModel = saveUserModel;
    }
    token = accessToken;
  }

  static Future<bool> chakeUserLoggedin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccessToken = sharedPreferences.getString(_tokenKey);
    if (userAccessToken != null) {
      getUserInformation();
      return true;
    }
    return false;
  }

  static Future<void> userLogout()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    token = null;
    userModel = null;
  }
}
