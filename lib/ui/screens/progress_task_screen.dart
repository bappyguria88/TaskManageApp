import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np/ui/controllers/progress_task_controller.dart';
import 'package:np/ui/widget/task_card.dart';
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
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.separated(
              itemCount: controller.progressTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskStatus: TaskStatus.progress,
                  taskModel: controller.progressTaskList[index],
                  refreshNewList: _getAllProgressTaskList,
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return Divider();
            },
            ),
          );
        },
      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {
    await Get.find<ProgressTaskController>().getProgressTaskList();
  }
}
