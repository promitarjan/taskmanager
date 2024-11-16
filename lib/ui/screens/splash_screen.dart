import 'package:flutter/material.dart';
import 'package:taskmanager/data/controllers/authentication_controller.dart';
import 'package:taskmanager/ui/screens/authentication/sign_in_screen.dart';
import 'package:taskmanager/ui/screens/views/main_nav_screen.dart';
import 'package:taskmanager/ui/widgets/image_background.dart';
import 'package:taskmanager/utils/image_path.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToNextScreen();
  }

  Future<void> _goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    await AuthController.getAccessToken();
    if (AuthController.isLoggedIn()) {
      await AuthController.getUserInfo();
      Get.offNamed(MainNavScreen.route);
    } else {
      Get.offNamed(SignInScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ImageBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.logoPng,
              width: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Task Manager',
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
    ));
  }
}
