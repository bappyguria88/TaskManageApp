import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np/controller_binder.dart';
import 'package:np/ui/screens/splash_screens.dart';
import 'package:np/ui/utils/assets/app_colors.dart';


class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreens(),
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          )
        ),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData()
      ),
    );



  }

  InputDecorationTheme _inputDecorationTheme(){
    return InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(
          fontSize: 14,fontWeight: FontWeight.w500
        ),
        border: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(),
        errorBorder: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder(),
        hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500
        )
    );
  }

  OutlineInputBorder _outlineInputBorder(){
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData(){
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            foregroundColor: AppColors.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
            fixedSize: const Size.fromWidth(double.maxFinite),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))
            )
        )
    );
  }
}
