import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:np/ui/screens/sign_in_screen.dart';

import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';
import '../utils/assets/app_colors.dart';
import '../widget/screen_background.dart';
import '../widget/show_snack_bar_message.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.otp, required this.email});

  final String email;
  final String otp;

  static const String name = '/forgot-password/set-password';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _newPasswordSetTEController =
      TextEditingController();
  final TextEditingController _conformNewPasswordSetTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordSetInProgress = false;

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
                  'Set New Password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
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
            controller: _newPasswordSetTEController,
            decoration: const InputDecoration(hintText: 'New Password'),
            validator: (String? value) {
              if (value!.trim().isEmpty) {
                return 'Enter a new Password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _conformNewPasswordSetTEController,
            decoration: const InputDecoration(hintText: 'Conform Password'),
            validator: (String? value) {
              if (value!.trim().isEmpty) {
                return 'Enter Conform new Password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _setNewPassword,
            child: const Icon(Icons.arrow_circle_right_outlined),
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

  void _setNewPassword() {
    if (_formKey.currentState!.validate()) {
      _resetPassword(_newPasswordSetTEController.text);
    }
  }

  void _moveToSignInScreens() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }


  Future<void> _resetPassword(String password) async {

    Map<String, dynamic> inputParams = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": password,
    };

    NetworkResponse response = await NetworkCaller.postReqest(
      url: Urls.setPasswordTaskUrl, body: inputParams,);

    if (response.isSuccess) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false,
        );
      }
    } else {
      if (mounted) {
        ShowSnackBarMessage(context, response.errorMessage);
      }
    }

  }
  @override
  void dispose() {
    super.dispose();
    _newPasswordSetTEController.dispose();
    _conformNewPasswordSetTEController.dispose();
  }

}
