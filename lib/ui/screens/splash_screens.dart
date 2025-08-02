import 'package:flutter/material.dart';
import 'package:np/ui/controllers/auth_controllers.dart';
import 'package:np/ui/screens/main_bottom_nav_bar.dart';
import 'package:np/ui/screens/sign_in_screen.dart';
import 'package:np/ui/screens/sign_up_screens.dart';

import '../widget/app_logo.dart';
import '../widget/screen_background.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});
  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {

  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future <void> moveToNextScreen()async{
    await Future.delayed(const Duration(seconds: 2));
    final bool isLoginUser =await AuthControllers.chakeUserLoggedin();
    if(isLoginUser == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainBottomNavScreen()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
    }


  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScreenBackround(child: AppLogo(),)
    );
  }
}


