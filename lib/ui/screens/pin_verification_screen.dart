import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/data/service/network_caller.dart';
import 'package:np/ui/controllers/auth_controllers.dart';
import 'package:np/ui/controllers/pin_verification_controller.dart';
import 'package:np/ui/screens/set_password_screen.dart';
import 'package:np/ui/screens/sign_in_screen.dart';
import 'package:np/ui/widget/show_snack_bar_message.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../utils/urls.dart';
import '../utils/assets/app_colors.dart';
import '../widget/screen_background.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({
    super.key,
    required this.email,
  });

  final String email;
  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackround(
        child: Padding(
          padding: const EdgeInsets.all(34.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 160,
              ),
              const Text(
                'Pin Verification',
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
              _buildVerificationEmailSection(),
              const SizedBox(
                height: 50,
              ),
              _buildSignInSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationEmailSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PinCodeTextField(
            controller: _pinTEController,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            keyboardType: TextInputType.number,
            appContext: context,
            validator: (String? value) {
              if (value!.trim().isEmpty) {
                return 'Enter Your Valid OTP';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          GetBuilder<PinVerificationController>(
            builder: (pinVerificationController) {
              return Visibility(
                visible: !pinVerificationController.inProgress,
                replacement: Center(child: CircularProgressIndicator()),
                child: ElevatedButton(
                  onPressed: _moveToPasswordScreen,
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
              );
            }
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
              recognizer: TapGestureRecognizer()..onTap = _moveToSignInScreens,
              style: const TextStyle(color: AppColors.themeColor),
            )
          ],
        ),
      ),
    );
  }

  void _moveToPasswordScreen() {
    if (_formKey.currentState!.validate()) {
      print('OTP');
      _otpVerify(widget.email, _pinTEController.text.trim());
    }
  }

  Future<void> _otpVerify(String email, String otp) async {

    bool isSuccess = await Get.find<PinVerificationController>().getPinVerification(email,otp);
    if (isSuccess) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SetPasswordScreen(
                    otp: otp, email: email,
                  )));
      ShowSnackBarMessage(context, 'OTP SUCCESS!');
    } else {
      ShowSnackBarMessage(context, Get.find<PinVerificationController>().errorMessage.toString());
    }
  }

  void _moveToSignInScreens() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }
}
