import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets/assets_path.dart';

class ScreenBackround extends StatelessWidget {
  const ScreenBackround({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),

        child
      ]
    );
  }
}