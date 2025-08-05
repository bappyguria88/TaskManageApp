import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/data/model/add_new_task_model.dart';
import 'package:np/ui/controllers/add_new_task_controller.dart';
import '../widget/screen_background.dart';


class AddNewTaskScreens extends StatefulWidget {
  const AddNewTaskScreens({super.key, required this.refreshNewList, required this.counRefershList, });

  final VoidCallback refreshNewList;
  final VoidCallback counRefershList;

  @override
  State<AddNewTaskScreens> createState() => _AddNewTaskScreensState();
}

class _AddNewTaskScreensState extends State<AddNewTaskScreens> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _discTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackround(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 160,
                ),
                const Text(
                  'Add new Task',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildSignInSection(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _buildSignInSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _titleTEController,
            decoration: const InputDecoration(hintText: 'Title'),
            validator: (String? value) {
              if (value!.trim().isEmpty) {
                return 'Enter A Title';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _discTEController,
            keyboardType: TextInputType.text,
            maxLines: 6,
            decoration: const InputDecoration(hintText: 'Discretion'),
            validator: (String? value) {
              if (value!.trim().isEmpty) {
                return 'Enter Your Discretion';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<AddNewTaskController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const Center(child: CircularProgressIndicator(),),
                child: ElevatedButton(
                  onPressed: _addNewTaskButton,
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Future<void> _addNewTaskButton() async {
    if (_formKey.currentState!.validate()) {

      final AddNewTaskModel addNewTaskModel = AddNewTaskModel(title: _titleTEController.text.trim(), description: _discTEController.text.trim(),stastus: 'New');

      final bool isSuccess = await Get.find<AddNewTaskController>().addNewTask(addNewTaskModel);
      if(isSuccess){

        widget.counRefershList();
        widget.refreshNewList();
      }
      if(isSuccess){
        _clearTextFile();
      }
    }
  }


  void _clearTextFile(){
    _titleTEController.clear();
    _discTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _discTEController.dispose();
  }
}
