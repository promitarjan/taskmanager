import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/controllers/sign_up_controller.dart';
import 'package:taskmanager/ui/screens/authentication/sign_in_screen.dart';
import 'package:taskmanager/utils/app_colors.dart';
import 'package:taskmanager/ui/widgets/image_background.dart';
import 'package:taskmanager/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String route = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  SignUpController signUpController = Get.find<SignUpController>();

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
                'Join With Us',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _buildSingUpFormField(),
              const SizedBox(
                height: 25,
              ),
              _buildSignInText()
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildSingUpFormField() {
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
            controller: _firstNameTEController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'First Name',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter first name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _lastNameTEController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Last Name',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter last name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _mobileTEController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Mobile',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter mobile number';
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

  Center _buildSignInText() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  text: "Have account? ",
                  children: [
                TextSpan(
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600),
                  text: 'Sign in',
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapSignInButton,
                )
              ])),
        ],
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _onTapSignUp();
    }
  }

  void _onTapSignUp() async {
    bool isSuccess = await signUpController.getSignUp(
      _emailTEController.text.trim(),
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _mobileTEController.text.trim(),
      _passwordTEController.text,
    );
    if (isSuccess) {
      _clearTEField();
      snackBarWidget(context: context, message: 'Registration Successful');
      Get.toNamed(SignInScreen.route);
    } else {
      snackBarWidget(
          context: context,
          message: signUpController.errorMessage!,
          isError: true);
    }
  }

  void _clearTEField() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignInButton() {
    Get.toNamed(SignInScreen.route);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}