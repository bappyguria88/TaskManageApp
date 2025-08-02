import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/ui/controllers/login_controller.dart';
import 'package:np/ui/screens/sign_up_screens.dart';
import '../utils/assets/app_colors.dart';
import '../widget/screen_background.dart';
import '../widget/show_snack_bar_message.dart';
import 'forgot_password_email_screen.dart';
import 'main_bottom_nav_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.find<LoginController>();

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
                  'Get Started With',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildSignInSection(),
                const SizedBox(
                  height: 50,
                ),
                _buildSignUpSection()
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailTEController,
              decoration: const InputDecoration(hintText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                RegExp regex =
                    new RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                if (!regex.hasMatch(value!)) {
                  return 'Enter Valid Email';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _passwordTEController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: false,
              keyboardType: TextInputType.visiblePassword,
              validator: (String? value) {
                if (value!.trim().isEmpty) {
                  return 'Email And Password No Match';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<LoginController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.signInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: _onTapSignInButton,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                );
              }
            ),
          ],
        ));
  }

  Widget _buildSignUpSection() {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordEmailScreen()));
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5),
              children: [
                TextSpan(
                  text: 'Sign Up',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                  style: const TextStyle(color: AppColors.themeColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _logIn();
    }
  }

  Future<void> _logIn() async {
    final bool isSuccess = await loginController.logIn(
        _emailTEController.text.trim(), _passwordTEController.text.trim());
    if (isSuccess) {
      ShowSnackBarMessage(context, 'Login Successfully!');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MainBottomNavScreen()),
          ModalRoute.withName('/'));
    } else {
      ShowSnackBarMessage(context, loginController.errorMessage!);
    }
  }
}
