import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:redically_local/app/config/AppTextStyles.dart';
import 'package:redically_local/app/config/global_var.dart';
import 'package:redically_local/app/util/util.dart';

import '../../../app/config/app_colors.dart';
import '../controllers/authentication_controller.dart';

class UploadSuccessPage extends GetView<AuthenticationController> {
  const UploadSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.0,
        top: MediaQuery.of(context).viewPadding.top + 50,
      ),
      child: GetBuilder<AuthenticationController>(builder: (cont) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 230,
              child: Image.asset(Utils.getImagePath("successimage")),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              child: Text(
                "${cont.fileresults?.path.split("/").last} uploaded successfully",
                style: AppTextStyle.regularPeta,
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Globals.isLocalEmployed && !Globals.residenceProofStatus) {
                  controller.landingcont.goToWorkHistory();
                } else {
                  controller.landingcont.startSecondAnimation();
                }
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
                  child: Center(
                    child: Text(
                      (Globals.isLocalEmployed == true &&
                              Globals.workHistoryStatus == false)
                          ? "Next"
                          : "Done",
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
            SizedBox(
              height: 90,
            ),
          ],
        );
      }),
    );
  }
}
