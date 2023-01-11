import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/config/app_colors.dart';

class TriangleImageScreen extends StatelessWidget {
  const TriangleImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.asset("assets/images/Mountains.png"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  "assets/images/mountainvector.svg",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
