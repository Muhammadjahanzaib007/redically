import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:redically_local/presentations/authentication/widgets/work_history_card.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/config/global_var.dart';
import '../controllers/authentication_controller.dart';

class WorkHistoryListPage extends GetView<AuthenticationController> {
  const WorkHistoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        initState: (cont) {
          cont.controller?.getWorkHistory();
        },
        builder: (controller) {
          return Column(
            children: [
              const Text(
                "Work History",
                style: AppTextStyle.boldTextLexendPeta,
              ),
              Expanded(
                  flex: 4,
                  child: ListView.builder(
                      itemCount: controller.workhistoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WorkHistoryCard(
                            workHistory: controller.workhistoryList[index]);
                      })),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.landingcont.goToWorkHistory();
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
                                "add more",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.buttonTextUnselected,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // controller.landingcont.startSecondAnimation();
                          if (Globals.isLocalResident &&
                              !Globals.residenceProofStatus) {
                            controller.landingcont.goToResidenceProof();
                          } else {
                            controller.landingcont.goToHome();
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
                                "Submit",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.buttonTextUnselected
                                    .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}
