import 'dart:convert';

import 'package:np/data/model/user_model.dart';

class LoginModel{
  late final String status;
  late final UserModel userModel;
  late final String token;

  LoginModel.fromJson(Map<String,dynamic> jsonData){
    status = 'status' ?? '';
    userModel = UserModel.fromJson(jsonData['data'] ?? {});
    token = jsonData['token'] ?? '';
  }
}