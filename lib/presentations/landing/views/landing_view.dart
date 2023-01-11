import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/presentations/landing/widgets/landing_widgets.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double boxHeight = Get.height - MediaQuery.of(context).viewPadding.top - 12;

    return GetBuilder<LandingController>(
        init: LandingController(),
        autoRemove: false,
        builder: (cont) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: BackgroundWrapper(
              child: SingleChildScrollView(
                child: AnimatedContainer(
                  height: Get.height,
                  duration: const Duration(seconds: 2),
                  color:
                      cont.isLogin ? Colors.transparent : AppColors.background,
                  child: SafeArea(
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: AlignmentDirectional.center,
                      children: [
                        AnimatedOpacity(
                          // If the widget is visible, animate to 0.0 (invisible).
                          // If the widget is hidden, animate to 1.0 (fully visible).
                          opacity: cont.trapezoidClicked ? 0.0 : 1.0,
                          duration: const Duration(seconds: 2),
                          child: const Padding(
                            padding:
                                EdgeInsets.only(left: 20.0, right: 20, top: 10),
                            child: Text(
                              'Welcome to Radically Local',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.headingShadow,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: cont.trapezoidClicked ? 0.0 : 1.0,
                          duration: const Duration(seconds: 2),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Please click the Silver ingot to \nget started.",
                              style: AppTextStyle.boldTextPara,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: Duration(seconds: 2),
                          child: cont.body,
                        ),
                        for (int i = cont.clone ? 0 : cont.trapezoidCount.from;
                            i < (cont.clone ? 6 : cont.trapezoidCount.to);
                            i++)
                          LandingWidgets.buildTrapezoid(
                              context,
                              i,
                              i % 2 == 0 ? true : false,
                              (boxHeight - 20),
                              controller),
                        for (int i = 6; i < 10; i++)
                          LandingWidgets.buildAditionalTrapezoid(context, i,
                              i % 2 == 0 ? true : false, boxHeight, controller),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
