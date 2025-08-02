import 'package:get/get.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';

class ForgotPasswordEmailController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late String _message;
  String get message => _message;


  Future<bool> getForgotPassword(String email) async {
    bool isSuccess = false;

    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getReqest(url: Urls.emailTaskStatusUrl(email));
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