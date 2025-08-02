import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/ui/controllers/forgot_password_email_controller.dart';
import 'package:np/ui/screens/pin_verification_screen.dart';
import 'package:np/ui/screens/sign_in_screen.dart';

import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';
import '../controllers/auth_controllers.dart';
import '../utils/assets/app_colors.dart';
import '../widget/screen_background.dart';
import '../widget/show_snack_bar_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool emailVerifyInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackround(
        child: Padding(
          padding: const EdgeInsets.all(34.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 160,
                ),
                const Text(
                  'Your Email Address',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                    'A 6 digits verification otp will be send to with email.',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                const SizedBox(
                  height: 24,
                ),
                _buildSignUpFormSection(),
                const SizedBox(
                  height: 50,
                ),
                _buildSignInSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpFormSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value!.trim().isEmpty) {
                return 'Enter Your Valid E-mail';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: emailVerifyInProgress == false,
            replacement: CircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _moveToOtpScreen,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
          children: [
            TextSpan(
              text: 'Sign In',
              recognizer: TapGestureRecognizer()..onTap = signInButton,
              style: const TextStyle(color: AppColors.themeColor),
            )
          ],
        ),
      ),
    );
  }

  void _moveToOtpScreen() {
    if (_formKey.currentState!.validate()) {
      _emailVerify(_emailTEController.text.trim());
    }
  }

  Future<void> _emailVerify(String email) async {
    bool isSuccess = await Get.find<ForgotPasswordEmailController>()
        .getForgotPassword(_emailTEController.text.trim());
    if (isSuccess) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PinVerificationScreen(
                  email: _emailTEController.text.trim())));
      ShowSnackBarMessage(context, 'A 6 digits code sent.');
    }else{
      ShowSnackBarMessage(context, Get.find<ForgotPasswordEmailController>().errorMessage.toString());
    }

  }

  void signInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (predicate) => false);
  }

  void _clearForm() {
    _emailTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
