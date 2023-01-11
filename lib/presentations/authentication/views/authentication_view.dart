import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:redically_local/app/util/util.dart';
import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        autoRemove: false,
        builder: (controller) {
          return Obx(() =>  ModalProgressHUD(
            progressIndicator: Image.asset(Utils.getImagePath('Scanner',format: 'gif',),color: AppColors.white,height: 150,width: 150,),
            inAsyncCall: controller.loading.value,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      Text(
                        "Radically\nLocal",
                        style: AppTextStyle.headingShadow
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        // onTap: widget.onclick,
                        child: SizedBox(
                          width: Get.width - 200,
                          height: 90,
                          // child: Container(
                          //   height: 90,
                          //   padding: EdgeInsets.all(10),
                          //   width: Get.width - 200,
                          //   decoration: BoxDecoration(
                          //       color: AppColors.buttonColor,
                          //       borderRadius: BorderRadius.circular(150)),
                          //   child: const Center(
                          //     child: Text(
                          //       "What is your role?",
                          //       textAlign: TextAlign.center,
                          //       style: AppTextStyle.buttonTextUnselected,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                      buildTextFeild(context, "Enter E-mail here",
                          controller.emailCont, controller.emailNode,
                          controller: controller),
                      Column(
                        children: [
                          buildTextFeild(context, "Enter Password here",
                              controller.passCont, controller.passNode,
                              obscure: true, controller: controller),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.landingcont.goToForgotPass();
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: AppTextStyle.buttonTextSelected,
                            ),
                          )
                        ],
                      ),
                      buildButton(context, "Submit", () => controller.signIn()),
                      const SizedBox(
                        height: 95,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: AppTextStyle.buttonTextUnselected),
                      InkWell(
                          onTap: () {
                            controller.emailCont.clear();
                            controller.passCont.clear();
                            controller.landingcont.goToSignUp();
                          },
                          child: Text(
                            " Sign up",
                            style: AppTextStyle.buttonTextUnselected,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
