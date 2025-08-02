import 'package:get/get.dart';

import '../../data/model/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';

class CancelTaskController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late String _message;
  String get message => _message;

  List<TaskModel> _cancelTaskList = [];
  List<TaskModel> get cancelTaskList => _cancelTaskList;

  Future<bool> getCancelTaskList() async {
    bool isSuccess = false;

    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getReqest(url: Urls.cancelTask);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for(Map<String,dynamic> item in response.responseData!['data']){
        list.add(TaskModel.fromJson(item));
      }
      _cancelTaskList = list;
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