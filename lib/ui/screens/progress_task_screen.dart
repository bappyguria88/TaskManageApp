import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/data/model/task_list_model.dart';
import 'package:np/data/model/task_model.dart';
import 'package:np/data/service/network_caller.dart';
import 'package:np/ui/controllers/progress_task_controller.dart';
import 'package:np/ui/widget/show_snack_bar_message.dart';
import 'package:np/ui/widget/task_card.dart';
import 'package:np/utils/urls.dart';
import '../widget/tmapp_bar.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});
  static const String name = '/progress-task/screen';
  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  @override
  void initState() {
    super.initState();
    _getAllProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: GetBuilder<ProgressTaskController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement: Center(child: CircularProgressIndicator()),
            child: ListView.builder(
              itemCount: controller.progressTaskList.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (contex, index) {
                return TaskCard(
                  taskStatus: TaskStatus.progress,
                  taskModel: controller.progressTaskList[index],
                  refreshNewList: () {
                    _getAllProgressTaskList();
                  },
                );
              },
            ),
          );
        }
      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {
    bool isSuccess = await Get.find<ProgressTaskController>().getProgressTaskList();
    if(isSuccess){
      ShowSnackBarMessage(context, Get.find<ProgressTaskController>().message);
    }else{
      ShowSnackBarMessage(context, Get.find<ProgressTaskController>().errorMessage.toString());
    }
  }
}
