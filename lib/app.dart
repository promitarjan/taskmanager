import 'package:flutter/material.dart';
import 'package:taskmanager/data/binding/initial_binding.dart';
import 'package:taskmanager/data/controllers/routes.dart';
import 'package:taskmanager/ui/screens/splash_screen.dart';
import 'package:taskmanager/utils/app_colors.dart';
import 'package:get/get.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorSchemeSeed: AppColors.primaryColor,
          inputDecorationTheme: _buildInputDecorationTheme(),
          elevatedButtonTheme: _buildElevatedButtonThemeData()),
      initialBinding: InitialBinding(),
      routes: Routes.route,
      initialRoute: SplashScreen.route,
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            fixedSize: const Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8))));
  }
}