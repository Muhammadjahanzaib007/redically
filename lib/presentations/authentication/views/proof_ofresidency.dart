import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:redically_local/app/config/AppTextStyles.dart';
import 'package:redically_local/app/shared/shared_widgets.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/util/util.dart';
import '../controllers/authentication_controller.dart';

class ProofOfResidency extends GetView<AuthenticationController> {
  const ProofOfResidency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.0,
        top: MediaQuery.of(context).viewPadding.top,
      ),
      child: GetBuilder<AuthenticationController>(
          init: AuthenticationController(),
          builder: (cont) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 70,
                  child: Text(
                    "Upload Proof of Residence",
                    style: AppTextStyle.boldTextLexendPeta,
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                GestureDetector(
                  onTap: () {
                    cont.pickImage();
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
                          cont.fileresults != null
                              ? "${cont.fileresults?.path.split("/").last}"
                              : "Add Image",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.buttonTextUnselected,
                        ),
                      ),
                    ),
                  ),
                ),
                buildButton(
                  context,
                  "Upload",
                  () {
                    if (controller.fileresults != null) {
                      controller.saveResidenceProof();
                    } else {
                      Utils.showSnackBar(
                          title: "Alert", message: "Select an Image First");
                    }
                  },
                  textStyle: AppTextStyle.regularPeta
                      .copyWith(color: Colors.white, fontSize: 16),
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
