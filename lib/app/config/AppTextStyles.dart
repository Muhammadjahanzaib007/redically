import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const TextStyle headingShadow = TextStyle(shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Colors.grey,
    ),
  ], fontSize: 40, fontFamily: "LexendPeta-Regular");
  static TextStyle headingShadow2 = const TextStyle(shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Colors.grey,
    ),
  ], fontSize: 20, fontFamily: "LexendPeta-Regular", color: AppColors.darkGrey);
  static const TextStyle boldTextPara =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static const TextStyle boldTextLexendPeta = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontFamily: "LexendPeta-SemiBold");
  static const TextStyle regularPeta =
      TextStyle(fontFamily: "LexendPeta-Regular");
  static const TextStyle mediumPeta =
      TextStyle(fontFamily: "LexendPeta-Medium");
  static const TextStyle semiBold =
      TextStyle(fontFamily: "LexendPeta-SemiBold");
  static const TextStyle buttonTextUnselected = TextStyle(
      color: Colors.white, fontSize: 10, fontFamily: "LexendPeta-Regular");
  static const TextStyle buttonTextSelected = TextStyle(
      color: Colors.black, fontSize: 10, fontFamily: "LexendPeta-Regular");
  static const TextStyle appBarTitle = TextStyle(
      color: Colors.black, fontSize: 22, fontFamily: "LexendPeta-Regular");
}
