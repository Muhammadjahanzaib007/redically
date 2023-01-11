import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/app/config/app_colors.dart';

import '../../../app/util/util.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: Image.asset(Utils.getImagePath("applogo")),
            ),
          );
        });
  }
}
