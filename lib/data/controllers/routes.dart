import 'package:flutter/cupertino.dart';
import 'package:taskmanager/ui/screens/authentication/forget_pass_email_verification_screen.dart';
import 'package:taskmanager/ui/screens/authentication/forget_pin_verification_screen.dart';
import 'package:taskmanager/ui/screens/authentication/forget_set_password_screen.dart';
import 'package:taskmanager/ui/screens/authentication/sign_in_screen.dart';
import 'package:taskmanager/ui/screens/authentication/sign_up_screen.dart';
import 'package:taskmanager/ui/screens/splash_screen.dart';
import 'package:taskmanager/ui/screens/views/add_new_task.dart';
import 'package:taskmanager/ui/screens/views/canceled_task_screen.dart';
import 'package:taskmanager/ui/screens/views/completed_task_screen.dart';
import 'package:taskmanager/ui/screens/views/main_nav_screen.dart';
import 'package:taskmanager/ui/screens/views/new_task_screen.dart';
import 'package:taskmanager/ui/screens/views/progress_task_screen.dart';
import 'package:taskmanager/ui/screens/views/update_profile.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> route = {
    SplashScreen.route: (context) => const SplashScreen(),
    SignInScreen.route: (context) => const SignInScreen(),
    SignUpScreen.route: (context) => const SignUpScreen(),
    ForgetSetPasswordScreen.route: (context) => const ForgetSetPasswordScreen(),
    ForgetPinVerificationScreen.route: (context) =>
        const ForgetPinVerificationScreen(),
    ForgetPassEmailVerificationScreen.route: (context) =>
        const ForgetPassEmailVerificationScreen(),
    AddNewTask.route: (context) => const AddNewTask(),
    CanceledTaskScreen.route: (context) => const CanceledTaskScreen(),
    CompletedTaskScreen.route: (context) => const CompletedTaskScreen(),
    NewTaskScreen.route: (context) => const NewTaskScreen(),
    ProgressTaskScreen.route: (context) => const ProgressTaskScreen(),
    UpdateProfile.route: (context) => const UpdateProfile(),
    MainNavScreen.route: (context) => const MainNavScreen(),
  };
}
