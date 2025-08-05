import 'dart:convert';

import 'package:get/get.dart';
import 'package:np/data/model/profile_updated_model.dart';
import 'package:np/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthControllers extends GetxController{
   String? _token;
   UserModel? _userModel;

  String? get token => _token;
  UserModel? get userModel => _userModel;


  static const String _tokenKey = 'token';
  static const String _userModelKey = 'user-data';

   Future<void> saveUserInformation(
      String accessToken, UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(_userModelKey, jsonEncode(user.toJson()));

    _token = accessToken;
    _userModel = user;
  }

   Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? saveUserModelString = sharedPreferences.getString(_userModelKey);

    if (saveUserModelString != null) {
      UserModel saveUserModel =
          UserModel.fromJson(jsonDecode(saveUserModelString));

      _userModel = saveUserModel;
    }
    _token = accessToken;
  }

   void updateProfile({String? firstName, String? lastName, String? mobile, String? photo}) {
     if (userModel != null) {
       if (firstName != null) userModel!.firstName = firstName;
       if (lastName != null) userModel!.lastName = lastName;
       if (mobile != null) userModel!.mobile = mobile;
       if (photo != null) userModel!.photo = photo;
       update(); // এটি AppBar সহ GetBuilder ইউআই রিফ্রেশ করবে
     }
   }

   Future<bool> chakeUserLoggedin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccessToken = sharedPreferences.getString(_tokenKey);
    if (userAccessToken != null) {
      getUserInformation();
      return true;
    }
    return false;
  }

   Future<void> userLogout()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    _token = null;
    _userModel = null;
  }

}
