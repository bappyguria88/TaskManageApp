import 'package:flutter/material.dart';
import 'package:np/data/model/task_model.dart';
import 'package:np/data/service/network_caller.dart';
import 'package:np/ui/widget/show_snack_bar_message.dart';

import '../../utils/urls.dart';

enum TaskStatus { sNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard(
      {super.key,
      required this.taskStatus,
      required this.taskModel,
      required this.refreshNewList,
      this.refreshTaskStatusCountList});

  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshNewList;
  final VoidCallback? refreshTaskStatusCountList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(widget.taskModel.description),
            // TODO: Format it with DateFormatter (intl)
            Text(widget.taskModel.createdDate),
            Row(
              children: [
                Chip(
                  backgroundColor: _getStatusChipColor(),
                  label: Text(
                    widget.taskModel.status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  // backgroundColor: ,
                  side: BorderSide.none,
                ),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _deleteTaskStatus();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                        onPressed: _showUpdateStatusDialog,
                        icon: const Icon(Icons.edit)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusChipColor() {
    late Color color;
    switch (widget.taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;
      case TaskStatus.progress:
        color = Colors.purple;
      case TaskStatus.completed:
        color = Colors.green;
      case TaskStatus.cancelled:
        color = Colors.red;
    }
    return color;
  }

  void _showUpdateStatusDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Updated Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _popDiglog();
                    if (isSelected('New')) return;
                    _changeTaskStatus('New');
                  },
                  title: Text('New'),
                  trailing: isSelected('New') ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDiglog();
                    if (isSelected('Progress')) return;
                    _changeTaskStatus('Progress');
                  },
                  title: Text('Progress'),
                  trailing: isSelected('Progress') ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDiglog();
                    if (isSelected('Completed')) return;
                    _changeTaskStatus('Completed');
                  },
                  title: Text('Completed'),
                  trailing: isSelected('Completed') ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDiglog();
                    if (isSelected('Cancel')) return;
                    _changeTaskStatus('Cancel');
                  },
                  title: Text('Cancel'),
                  trailing: isSelected('Cancel') ? Icon(Icons.done) : null,
                ),
              ],
            ),
          );
        });
  }

  bool isSelected(String status) => widget.taskModel.status == status;

  Future<void> _changeTaskStatus(String status) async {
    inProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getReqest(
        url: Urls.updatedTaskStatusUrl(widget.taskModel.id, status));

    inProgress = false;
    if (response.isSuccess) {
      widget.refreshNewList();
      if (widget.refreshTaskStatusCountList != null) {
        widget.refreshTaskStatusCountList!();
      } else {
        return;
      }
    } else {
      setState(() {});
      ShowSnackBarMessage(context, response.errorMessage);
    }
  }

  void _popDiglog() {
    Navigator.pop(context);
  }

  Future<void> _deleteTaskStatus() async {
    inProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getReqest(
        url: Urls.deleteTaskStatusUrl(widget.taskModel.id));

    inProgress = false;
    if (response.isSuccess) {
      widget.refreshNewList();
      if (widget.refreshTaskStatusCountList != null) {
        widget.refreshTaskStatusCountList!();
      } else {
        return;
      }
    } else {
      setState(() {});
      ShowSnackBarMessage(context, response.errorMessage);
    }
  }
}
