import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:redically_local/app/util/util.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
      progressIndicator: Image.asset(Utils.getImagePath('Scanner',format: 'gif',),color: AppColors.white,height: 150,width: 150,),
      inAsyncCall: controller.loading.value,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: buildAppBar(Text('Feedback',
            style: AppTextStyle.appBarTitle
                .copyWith(color: const Color(0xffA5CE71)))),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65),
                  child: GetBuilder<FeedbackController>(builder: (controller) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: 55,
                        ),
                        buildTextFeild(context, "Enter Your Name",
                            controller.nameCont, controller.nameNode,
                            controller: controller,
                            height: 75,
                            width: Get.width - 150,
                            hintStyle: AppTextStyle.regularPeta
                                .copyWith(color: Colors.white, fontSize: 16)),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFeild(context, "Enter Your Email",
                            controller.emailCont, controller.emailNode,
                            controller: controller,
                            height: 75,
                            width: Get.width - 150,
                            hintStyle: AppTextStyle.regularPeta
                                .copyWith(color: Colors.white, fontSize: 16)),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.messageNode.requestFocus();
                            controller.update();
                          },
                          child: Container(
                            height: 160,
                            padding: const EdgeInsets.all(30),
                            width: Get.width - 150,
                            decoration: BoxDecoration(
                                color: controller.messageNode.hasFocus
                                    ? AppColors.white
                                    : AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(37.5)),
                            child: TextField(
                              controller: controller.messageCont,
                              focusNode: controller.messageNode,
                              onTap: () {
                                controller.update();
                              },
                              maxLines: 7,
                              cursorColor: controller.messageNode.hasFocus
                                  ? AppColors.buttonColor
                                  : Colors.white,
                              style: controller.messageNode.hasFocus
                                  ? AppTextStyle.buttonTextSelected
                                  : AppTextStyle.buttonTextUnselected,
                              decoration: InputDecoration.collapsed(
                                  hintText: controller.messageNode.hasFocus
                                      ? ""
                                      : "Enter your message...",
                                  hintStyle: controller.messageNode.hasFocus
                                      ? AppTextStyle.buttonTextSelected
                                      : AppTextStyle.buttonTextUnselected),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildButton(
                            context, "Submit", () => controller.submitFeedback(),
                            height: 75,
                            width: Get.width - 150,
                            textStyle: AppTextStyle.regularPeta
                                .copyWith(color: Colors.white, fontSize: 20)),


                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(height: 5,),
            GestureDetector(
              onTap: () {
                controller.launchCaller("0099829182910");
              },
              child: Wrap(
                children: [
                  Image.asset(
                    Utils.getIconPath("phoneicon"),
                    height: 18,
                  ),
                  Text(
                    " 0099829182910",
                    style: AppTextStyle.regularPeta.copyWith(fontSize: 12),
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
            GestureDetector(
              onTap: () {
                controller.launchMail("business@hotmail.com");
              },
              child: Wrap(
                children: [
                  Image.asset(
                    Utils.getIconPath("mailicon"),
                    height: 18,
                  ),
                  Text(
                    " business@hotmail.com",
                    style: AppTextStyle.regularPeta.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],),
        ),
      ),
    ));
  }
}
