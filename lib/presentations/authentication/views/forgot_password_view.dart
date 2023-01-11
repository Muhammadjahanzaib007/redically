import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:redically_local/app/config/AppTextStyles.dart';
import 'package:redically_local/app/shared/shared_widgets.dart';
import 'package:redically_local/app/util/util.dart';

import '../../../app/config/app_colors.dart';
import '../controllers/authentication_controller.dart';

class ForgotPasswordPage extends GetView<AuthenticationController> {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.0,
        top: MediaQuery.of(context).viewPadding.top,
      ),
      child: GetBuilder<AuthenticationController>(builder: (cont) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              child: Image.asset(Utils.getImagePath("reset-password")),
            ),
            SizedBox(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Enter Email To Receive a",
                    style: AppTextStyle.semiBold,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Verification Code",
                    style: AppTextStyle.semiBold,
                  ),
                ],
              ),
            ),
            buildTextFeild(context, "Enter Email", controller.emailCont,
                controller.emailNode,
                controller: controller),
            GestureDetector(
              onTap: () async {
                controller.forgotPassword();
              },
              child: SizedBox(
                width: Get.width - 200,
                height: 90,
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(10),
                  width: Get.width - 200,
                  decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(150)),
                  child: const Center(
                    child: Text(
                      "Verify",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.buttonTextUnselected,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
          ],
        );
      }),
    );
  }
}
