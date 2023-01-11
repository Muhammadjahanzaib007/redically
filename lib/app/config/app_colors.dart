import 'package:flutter/material.dart';

class AppColors {
  static const Color kWhite = Colors.white;
  static const Color kTransparent = Colors.transparent;
  static const Color kGrey = Color(0xffF2F2F2);
  static const Color kBoxGrey = Color(0xffF5F5F5);
  static const Color kBoxGrey2 = Color(0xffF9F9F9);
  static const Color kBoxGrey3 = Color(0xffc6c6c6);
  static const Color kBoxGrey4 = Color(0xffD9D9D9);
  static const Color appGrey = Color(0xffF2F2F2);
  static const Color dividerColor = Color(0xffE0E0E0);
  static const Color black = Colors.black;
  static const Color dimBlack = Color(0xff666666);
  static const Color tagsColor = Color(0xffC4C4C4);
  // static const Color primaryBlue = Color(0xff00A8EA);
  static const Color textBlack = Color(0xff737373);
  static const Color textBlue = Color(0xff200E32);
  static const Color filterTextGrey = Color(0xff808080);
  static const Color cuisineBlack = Color(0xff1B1B1B);
  static const Color textBlackLight = Color(0xffE0E0E0);
  static const Color greyWhite = Color(0xffEFEFEF);
  // static const Color facbookColor = Color(0xff4267B2);
  static const Color kPrimary = Color(0xff404852);
  static const Color kSecondary = Color(0xff88BB53);

  static const Color redColor = Color(0xffFF6262);
  static const Color greenColor = Color(0xff4eb928);
  static const Color background = Color(0xffFDF7F2);
  static const Color backgroundBlue = Color(0xffa2c5e7);
  static const Color backgroundYellow = Color(0xfff7dbb8);
  static const Color backgroundPink = Color(0xffFBDCD3);
  static const Color white = Color(0xffFFFFFF);
  static const Color buttonColor = Color(0xff212d3d);
  static const Color darkGrey = Color(0xff535353);
  static const Color lightGrey = Color(0xffd9d9d9);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
