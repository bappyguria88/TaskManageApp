import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/data/model/task_model.dart';
import 'package:np/ui/controllers/complete_task_controller.dart';
import 'package:np/ui/widget/show_snack_bar_message.dart';
import 'package:np/ui/widget/task_card.dart';
import '../widget/tmapp_bar.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});
  static const String name = '/completed-task/screen';
  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: GetBuilder<CompleteTaskController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: ListView.builder(
              itemCount: controller.completedTaskList.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (contex, index) {
                return TaskCard(
                  taskStatus: TaskStatus.completed,
                  taskModel: controller.completedTaskList[index],
                  refreshNewList: _getAllCompletedTaskList,
                );
              },
            ),
          );
        }
      ),
    );
  }

  Future <void> _getAllCompletedTaskList() async {
    bool isSuccess = await Get.find<CompleteTaskController>()
        .getCompletedTaskList();
    if (isSuccess) {

    }else{
      ShowSnackBarMessage(context, Get.find<CompleteTaskController>().errorMessage.toString());
    }
  }
}
