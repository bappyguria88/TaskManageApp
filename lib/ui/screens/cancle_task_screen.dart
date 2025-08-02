import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/data/model/task_model.dart';
import 'package:np/ui/widget/task_card.dart';
import '../../data/model/task_list_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';
import '../controllers/cancle_task_controller.dart';
import '../widget/show_snack_bar_message.dart';
import '../widget/tmapp_bar.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});
  static const String name = '/completed-task/screen';
  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  List<TaskModel> _cancleTaskList = [];
  bool _getCancleTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getAllCancelTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TMAppBar(),
        body: GetBuilder<CancelTaskController>(
          builder: (cancelController) {
            return Visibility(
              visible:cancelController.inProgress == false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                itemCount: cancelController.cancelTaskList.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (contex, index) {
                  return TaskCard(
                      taskStatus: TaskStatus.cancelled,
                      taskModel: cancelController.cancelTaskList[index],
                      refreshNewList: _getAllCancelTaskList);
                },
              ),
            );
          }
        ));
  }

  Future<void> _getAllCancelTaskList() async {
    bool isSuccess = await Get.find<CancelTaskController>().getCancelTaskList();
    if(isSuccess){}else{
      ShowSnackBarMessage(context, Get.find<CancelTaskController>().errorMessage.toString());
    }
  }
}
