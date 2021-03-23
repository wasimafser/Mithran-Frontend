import 'package:flutter/widgets.dart';

class ScreenSize {
  static double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static bool isLargeScreen(BuildContext context){
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context){
    var context_width = MediaQuery.of(context).size.width;
    return context_width < 1200 && context_width > 800;
  }

  static bool isSmallScreen(BuildContext context){
    return MediaQuery.of(context).size.width < 800;
  }
}