import 'package:flutter/cupertino.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height) // Add line p1p2
      ..lineTo(size.width * 0.5, size.height) // Add line p2p3
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
