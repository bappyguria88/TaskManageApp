import 'package:get/get.dart';
import 'package:np/ui/controllers/add_new_task_controller.dart';
import 'package:np/ui/controllers/auth_controllers.dart';
import 'package:np/ui/controllers/cancle_task_controller.dart';
import 'package:np/ui/controllers/complete_task_controller.dart';
import 'package:np/ui/controllers/forgot_password_email_controller.dart';
import 'package:np/ui/controllers/login_controller.dart';
import 'package:np/ui/controllers/new_task_controller.dart';
import 'package:np/ui/controllers/pin_verification_controller.dart';
import 'package:np/ui/controllers/profile_updated_controller.dart';
import 'package:np/ui/controllers/progress_task_controller.dart';
import 'package:np/ui/controllers/sign_up_controller.dart';
import 'package:np/ui/controllers/task_status_count_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthControllers());
    Get.put(LoginController());
    Get.put(ProfileUpdatedController());
    Get.put(TaskStatusCountController());
    Get.put(NewTaskController());
    Get.put(SignUpController());
    Get.put(AddNewTaskController());
    Get.put(ProgressTaskController());
    Get.put(CompleteTaskController());
    Get.put(CancelTaskController());
    Get.put(ForgotPasswordEmailController());
    Get.put(PinVerificationController());
  }
}