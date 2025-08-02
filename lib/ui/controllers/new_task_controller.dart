import 'package:get/get.dart';
import 'package:np/data/model/task_model.dart';

import '../../data/model/task_list_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';

class NewTaskController extends GetxController{
bool _getNewTasksInProgress = false;
bool get getNewTasksInProgress => _getNewTasksInProgress;

List<TaskModel> _newTaskList = [];
List<TaskModel> get newTaskList => _newTaskList;

String? _errorMessage;
String? get errorMessage => _errorMessage;




  Future<bool> getAllNewTaskList() async {
    bool isSuccess = false;

    _getNewTasksInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getReqest(url: Urls.newTask);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for(Map<String,dynamic> item in response.responseData!['data']){
        list.add(TaskModel.fromJson(item));
      }
      _newTaskList = list;
      isSuccess = true;
      _errorMessage = null;

    } else {
      _errorMessage = response.errorMessage;
    }

    _getNewTasksInProgress = false;
    update();

    return isSuccess;
  }
}