import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np/ui/controllers/new_task_controller.dart';
import 'package:np/ui/controllers/task_status_count_controller.dart';
import 'package:np/ui/widget/show_snack_bar_message.dart';
import '../widget/task_card.dart';
import '../widget/task_summry_count.dart';
import '../widget/tmapp_bar.dart';

class NewTaskScreens extends StatefulWidget {
  const NewTaskScreens({super.key});

  static const String name = '/new-task/screen';

  @override
  State<NewTaskScreens> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<NewTaskScreens> {
  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    _getAllNewTaskList();
  }

  Future<void> newPageRefeesh() async {
    await _getAllTaskStatusCount();
    await _getAllNewTaskList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: RefreshIndicator(
        onRefresh: newPageRefeesh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [_buildSummryCountSection(), _buildTaskListView()],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView() {
    return GetBuilder<NewTaskController>(builder: (controller) {
      return Visibility(
        visible: controller.getNewTasksInProgress == false,
        replacement: Center(child: CircularProgressIndicator()),
        child: ListView.separated(
          itemCount: controller.newTaskList.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (contex, index) {
            return TaskCard(
              taskModel: controller.newTaskList[index],
              taskStatus: TaskStatus.sNew,
              refreshNewList: _getAllNewTaskList,
              refreshTaskStatusCountList: _getAllTaskStatusCount,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      );
    });
  }

  Widget _buildSummryCountSection() {
    return GetBuilder<TaskStatusCountController>(builder: (controller) {
      return Visibility(
        visible: controller.taskStatusCountInProgress == false,
        replacement: Center(child: CircularProgressIndicator()),
        child: SizedBox(
          height: 150,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.taskStatusCountList.length,
              itemBuilder: (context, index) {
                return CardSummaryCount(
                  title: controller.taskStatusCountList[index].status,
                  count: controller.taskStatusCountList[index].count.toString(),
                );
              }),
        ),
      );
    });
  }

  Future<void> _getAllTaskStatusCount() async {
    final bool isSuccess =
        await Get.find<TaskStatusCountController>().getAllTaskStatusCount();
    if (!isSuccess) {
      ShowSnackBarMessage(
          context, Get.find<TaskStatusCountController>().errorMessage!);
    }
  }

  Future<void> _getAllNewTaskList() async {
    bool isSuccess = await Get.find<NewTaskController>().getAllNewTaskList();
    if (!isSuccess) {
      ShowSnackBarMessage(context, Get.find<NewTaskController>().errorMessage!);
    }
  }
}
