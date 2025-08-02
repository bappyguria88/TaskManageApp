import 'package:get/get.dart';

import '../../data/model/login_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';
import 'auth_controllers.dart';

class LoginController extends GetxController{
  bool _signInProgress = false;
  bool get signInProgress => _signInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> logIn (String email, String password)async {
    bool isSuccess = false;

    _signInProgress = true ;
    update();

    Map<String,dynamic> reqestBody = {
      "email":email,
      "password":password
    };

    NetworkResponse response = await NetworkCaller.postReqest(url: Urls.loginUrl,body: reqestBody);

    if(response.isSuccess){

      LoginModel loginModel = LoginModel.fromJson(response.responseData!);
      AuthControllers.saveUserInformation(loginModel.token,loginModel.userModel);

      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }

    _signInProgress = false;
    update();
    return isSuccess;
  }
}