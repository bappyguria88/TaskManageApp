import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:np/data/model/user_model.dart';
import 'package:np/ui/controllers/auth_controllers.dart';
import '../../data/service/network_caller.dart';
import '../../utils/urls.dart';
import '../widget/show_snack_bar_message.dart';
import '../widget/tmapp_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  bool profileUpdatedInProgress = false;

  @override
  void initState() {
    super.initState();
    UserModel userModel = AuthControllers.userModel!;
    _emailTEController.text = userModel.email;
    _firstNameTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _mobileTEController.text = userModel.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        isProfileScreensOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 82,
                ),
                Text(
                  'Update Profile',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildPhotoPicker(),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailTEController,
                  enabled: false,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your First Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your Last Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _mobileTEController,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your Mobile';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordTEController,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  replacement: CircularProgressIndicator(),
                  visible: profileUpdatedInProgress == false,
                  child: ElevatedButton(
                    onPressed: onTapSubmitButton,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildPhotoPicker() => Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTapPhotoPicker,
              child: Container(
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                alignment: Alignment.center,
                child: const Text(
                  'Photo',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(_pickedImage?.name ?? 'Selected Photo')
          ],
        ),
      );

  void onTapPhotoPicker() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _pickedImage = image;

      setState(() {});
    }
  }

  void onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _profileUpdated();
    }
  }

  Future<void> _profileUpdated() async {
    profileUpdatedInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text,
      "lastName": _lastNameTEController.text,
      "mobile": _mobileTEController.text,
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_pickedImage != null) {
      List<int> imagBytes = await _pickedImage!.readAsBytes();
      String encodImage = base64Encode(imagBytes);
      requestBody['photo'] = encodImage;
    }

    final NetworkResponse response = await NetworkCaller.postReqest(
        url: Urls.profileUpdatedUrl, body: requestBody);

    if (response.isSuccess) {
      _passwordTEController.clear();
      ShowSnackBarMessage(context, 'Registration Successfully!');
    } else {
      ShowSnackBarMessage(context, response.errorMessage);
    }
    profileUpdatedInProgress = false;
    setState(() {});
  }
}
