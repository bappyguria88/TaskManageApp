import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:np/ui/controllers/auth_controllers.dart';
import '../screens/profile_screens.dart';
import '../screens/sign_in_screen.dart';
import '../utils/assets/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreensOpen = false,
  });

  final bool isProfileScreensOpen;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControllers>(
      builder: (controller) {
        return AppBar(
          backgroundColor: AppColors.themeColor,
          title: Row(
            children: [
              CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.whiteColor,
                  backgroundImage: _shuldShowImage(controller.userModel?.photo)
                      ? MemoryImage(base64Decode(controller.userModel!.photo))
                      : null,),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isProfileScreensOpen) {
                      return;
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));}
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userModel?.fullName ?? 'Unknowns',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        controller.userModel?.email ?? 'Unknowns',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.userLogout();

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignInScreen()), (predicate)=> false);
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
        );
      }
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  bool _shuldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }
}
