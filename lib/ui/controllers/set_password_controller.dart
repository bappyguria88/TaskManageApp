import 'package:get/get.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';

class SetPasswordController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late String _message;
  String get message => _message;


  Future<bool> setPassword(String email,String otp,String password) async {
    bool isSuccess = false;

    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.postReqest(url: Urls.setPasswordTaskUrl,body: );
    if (response.isSuccess) {

      isSuccess = true;
      _errorMessage = null;

    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}