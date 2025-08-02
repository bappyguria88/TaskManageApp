import 'package:get/get.dart';

import '../../data/model/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';

class CompleteTaskController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late String _message;
  String get message => _message;

  List<TaskModel> _completedTaskList = [];
  List<TaskModel> get completedTaskList => _completedTaskList;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;

    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getReqest(url: Urls.completedTask);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for(Map<String,dynamic> item in response.responseData!['data']){
        list.add(TaskModel.fromJson(item));
      }
      _completedTaskList = list;
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