import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:redically_local/app/config/app_colors.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/silver_balance_controller.dart';

class SilverBalanceView extends GetView<SilverBalanceController> {
  const SilverBalanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildAppBar(Text('Silver Balance',
          style: AppTextStyle.appBarTitle
              .copyWith(color: const Color(0xffA2A4AF)))),
      body: GetBuilder<SilverBalanceController>(
          init: SilverBalanceController(),
          builder: (controller) {
            Widget body = controller.getScreen();
            return Column(
              children: [
                AnimatedContainer(
                  height: controller.showPerks ? 300 : 400,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: AppColors.lightGrey, width: 20),
                        bottom:
                            BorderSide(color: AppColors.lightGrey, width: 8),
                        left: BorderSide(color: AppColors.lightGrey, width: 8),
                        right: BorderSide(color: AppColors.lightGrey, width: 8),
                      )),
                  duration: const Duration(milliseconds: 1300),
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1300),
                      child: body),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 1300),
                      opacity: controller.showProgress ? 1 : 0,
                      child: IgnorePointer(
                        ignoring: !controller.showProgress,
                        child: InkWell(
                            onTap: () {
                              controller.showPerks = true;
                              controller.update();
                            },
                            child: Container(
                              height: 65,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(200)),
                              child: Center(
                                child: Text(
                                  controller.showPerks
                                      ? "Apply"
                                      : "Earned Perks",
                                  style: AppTextStyle.regularPeta
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
