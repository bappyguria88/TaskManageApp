import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np/data/model/sign_up_moddel.dart';
import 'package:np/ui/controllers/sign_up_controller.dart';
import 'package:np/ui/screens/sign_in_screen.dart';

import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';
import '../utils/assets/app_colors.dart';
import '../widget/screen_background.dart';
import '../widget/show_snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackround(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 160,
                ),
                const Text(
                  'Join With Us',
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              RegExp regex =
              RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              if (!regex.hasMatch(value!)) {
                return 'Enter Valid Email';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _firstNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'First Name'),
            keyboardType: TextInputType.text,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your First Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _lastNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              hintText: 'Last Name',
            ),
            keyboardType: TextInputType.text,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your Last Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _mobileTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Mobile'),
            keyboardType: TextInputType.number,
            validator: (String? value) {
              RegExp regex = RegExp(r'^(?:\+?88|0088)?01[13-9]\d{8}$');

              if(!regex.hasMatch(value!)){
                return 'Enter Your Valid Number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _passwordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Password'),
            keyboardType: TextInputType.visiblePassword,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your Password';
              }
              if (value!.length < 6) {
                return 'Enter Your Password 6 Letter';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<SignUpController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ElevatedButton(
                  onPressed: _onTapSignUpButton,
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

  void _moveToSignInScreens() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  void _onTapSignUpButton() async {
    final SignUpModel model = SignUpModel(
      email: _emailTEController.text.trim(),
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      mobile: _mobileTEController.text.trim(),
      password: _passwordTEController.text,
    );
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await Get.find<SignUpController>().signUp(model);
      _clearTextFields();
      if(isSuccess){
        ShowSnackBarMessage(context, Get.find<SignUpController>().message);
      }else{
        ShowSnackBarMessage(context, Get.find<SignUpController>().errorMessage.toString());

      }
    }
  }


  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }
}
