import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:np/data/model/sign_up_moddel.dart';
import 'package:np/ui/widget/show_snack_bar_message.dart';

import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';

class SignUpController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late String _message;
  String get message => _message;

  Future<bool> signUp(SignUpModel model)async{
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.postReqest(url: Urls.registrationUrl,body: model.toJson());
    if(response.isSuccess){
    isSuccess = true;
    _message = response.responseData!['status'];
    _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}