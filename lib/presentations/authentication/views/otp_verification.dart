import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/app/config/AppTextStyles.dart';
import 'package:redically_local/app/shared/shared_widgets.dart';
import 'package:redically_local/app/util/util.dart';

import '../../../app/config/app_colors.dart';
import '../controllers/authentication_controller.dart';

class OtpVerificationView extends GetView<AuthenticationController> {
  final bool EmailVerify;
  const OtpVerificationView({
    Key? key,
    required this.EmailVerify,
  }) : super(key: key);

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
              child: Image.asset(Utils.getImagePath("opt_img")),
            ),
            SizedBox(
              height: 50,
              child: Column(
                children: [
                  Text(
                    "Please Enter The OTP Code Sent To",
                    style: AppTextStyle.semiBold,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    controller.emailCont.text,
                    style: AppTextStyle.semiBold.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            buildTextFeild(context, "Enter your OTP", controller.otpCont,
                controller.otpNode,
                controller: controller, inputType: TextInputType.number),
            buildButton(
              context,
              "Verify",
              () async {
                if (EmailVerify) {
                  await controller.verifyEmail();
                } else {
                  controller.verifyFrgtPassOtp();
                }
              },
              textStyle: AppTextStyle.mediumPeta.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 90,
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the OTP? ",
                      style: AppTextStyle.regularPeta.copyWith(fontSize: 11),
                    ),
                    InkWell(
                        onTap: () {
                          if (controller.enableResend) {
                            controller.resendOtp();
                          }
                        },
                        child: Text(
                          "Resend",
                          style: AppTextStyle.mediumPeta.copyWith(
                              fontSize: 12,
                              color: controller.enableResend
                                  ? AppColors.buttonColor
                                  : AppColors.dimBlack),
                        )),
                    if (controller.secondsRemaining != 0)
                      Text(
                        " in ${controller.secondsRemaining}",
                        style: AppTextStyle.regularPeta.copyWith(fontSize: 11),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
