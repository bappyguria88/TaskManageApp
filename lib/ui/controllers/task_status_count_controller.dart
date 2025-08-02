import 'package:get/get.dart';
import 'package:np/data/model/task_model.dart';

import '../../data/model/task_status_count_list_model.dart';
import '../../data/model/task_status_count_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';

class TaskStatusCountController extends GetxController{

  bool _taskStatusCountInProgress = false;
  bool get taskStatusCountInProgress => _taskStatusCountInProgress;

  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;



  Future<bool> getAllTaskStatusCount() async {
    bool isSuccess = false;

    _taskStatusCountInProgress = true;
    update();

    NetworkResponse response =
    await NetworkCaller.getReqest(url: Urls.taskStatusCount);

    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
      TaskStatusCountListModel.fromJson(response.responseData ?? {});

      _taskStatusCountList = taskStatusCountListModel.statusCountList;

      isSuccess = true;
      _errorMessage = null;
    } else {

      _errorMessage =  response.errorMessage;
    }

    _taskStatusCountInProgress = false;
    update();
    return isSuccess;
  }

}