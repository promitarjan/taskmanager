import 'package:get/get.dart';
import 'package:taskmanager/data/controllers/add_new_task_controller.dart';
import 'package:taskmanager/data/controllers/canceled_task_controller.dart';
import 'package:taskmanager/data/controllers/completed_task_controller.dart';
import 'package:taskmanager/data/controllers/new_task_controller.dart';
import 'package:taskmanager/data/controllers/new_task_count_controller.dart';
import 'package:taskmanager/data/controllers/progress_task_controller.dart';
import 'package:taskmanager/data/controllers/reset_password_controller.dart';
import 'package:taskmanager/data/controllers/sign_in_controller.dart';
import 'package:taskmanager/data/controllers/sign_up_controller.dart';
import 'package:taskmanager/data/controllers/update_profile_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignInController(),
    );
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => CanceledTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => NewTaskCountController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => UpdateProfileController());
    Get.lazyPut(() => ResetPasswordController());
  }
}
