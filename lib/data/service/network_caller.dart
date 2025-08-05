import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:np/app.dart';
import 'package:np/ui/controllers/auth_controllers.dart';
import 'package:np/ui/screens/sign_in_screen.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.responseData,
    this.errorMessage = 'Something Went wrong!',
  });
}

class NetworkCaller extends GetxController{
  
  static Future<NetworkResponse> getReqest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $uri');
      Map<String, String> headers = {'token': Get.find<AuthControllers>().token ?? ''};
      Response response = await get(uri, headers: headers);
      debugPrint('Status Code => ${response.statusCode}');
      debugPrint('Status Code => ${response.body}');

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodeData);
      }else if (response.statusCode == 401) {
        _moveToLoginScreen();
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: 'Un-authorize User');
      }  else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postReqest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $uri');

      Map<String, String> headers = {
        'content-type': 'application/json',
        'token': Get.find<AuthControllers>().token ?? ''
      };
      Response response =
          await post(uri, headers: headers, body: jsonEncode(body));
      debugPrint('Status Code => ${response.statusCode}');
      debugPrint('Response Data => ${response.body}');

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodeData);
      } else if (response.statusCode == 401) {
        _moveToLoginScreen();
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: 'Un-authorize User');
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static void _moveToLoginScreen() async {
    await Get.find<AuthControllers>().userLogout();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorState.currentContext!,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (predicate) => false);
  }
}
