import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/controllers/sign_in_controller.dart';
import 'package:taskmanager/ui/screens/authentication/forget_pass_email_verification_screen.dart';
import 'package:taskmanager/ui/screens/authentication/sign_up_screen.dart';
import 'package:taskmanager/ui/screens/views/main_nav_screen.dart';
import 'package:taskmanager/utils/app_colors.dart';
import 'package:taskmanager/ui/widgets/image_background.dart';
import 'package:taskmanager/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static String route = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  SignInController signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ImageBackground(
          child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get Started With',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _buildSingInFormField(),
              const SizedBox(
                height: 25,
              ),
              _buildForgetPasswordText()
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildSingInFormField() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter valid email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passwordTEController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter valid password';
              }
              if (value!.length < 6) {
                return 'Please enter minimum 6 characters password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: _onTapSubmitButton,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
              )),
        ],
      ),
    );
  }

  Center _buildForgetPasswordText() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: _onTapForgetPasswordButton,
              child: const Text(
                'Forget Password?',
                style: TextStyle(color: Colors.grey),
              )),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  text: "Don't have account? ",
                  children: [
                TextSpan(
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600),
                  text: 'Sign up',
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapSignUpButton,
                )
              ])),
        ],
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _onTapLogin();
    }
  }

  void _onTapLogin() async {
    bool isSuccess = await signInController.getLogin(
      _emailTEController.text,
      _passwordTEController.text,
    );
    if (isSuccess) {
      _clearTEField();
      Get.offAllNamed(
        MainNavScreen.route,
        predicate: (route) => false,
      );
    } else {
      snackBarWidget(
          context: context,
          message: signInController.errorMessage!,
          isError: true);
    }
  }

  void _clearTEField() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapForgetPasswordButton() {
    Get.toNamed(ForgetPassEmailVerificationScreen.route);
  }

  void _onTapSignUpButton() {
    Get.toNamed(SignUpScreen.route);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}