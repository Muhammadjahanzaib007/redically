import 'package:flutter/cupertino.dart';

import '../config/app_colors.dart';

// class CustomClipperMenu extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(size.width / 2, 0.0);
//     path.lineTo(0, size.height * 0.8);
//     // path.lineTo(0.0, size.height);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

class CustomClipperMenu extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColors.backgroundPink
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.5, 0);
    path0.lineTo(0, size.height * 0.9);
    path0.lineTo(0, 0);
    path0.lineTo(size.width * 0.5, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
