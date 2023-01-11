import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/authentication_controller.dart';

class SignUpView extends GetView<AuthenticationController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        autoRemove: false,
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).viewPadding.top == 0
                          ? 30
                          : MediaQuery.of(context).viewPadding.top,
                    ),
                    buildTextFeild(context, "Enter Your Name",
                        controller.firstNameCont, controller.nameNode,
                        controller: controller),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFeild(context, "Enter your E-mail",
                        controller.emailCont, controller.emailNode,
                        controller: controller),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFeild(context, "Enter your Password",
                        controller.passCont, controller.passNode,
                        obscure: true, controller: controller),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFeild(context, "Confirm your Password",
                        controller.confirmpassCont, controller.confirmpassNode,
                        obscure: true, controller: controller),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: buildSlideableButton(
                          context, "Are you a local resident?", (str) {
                        if (str.contains("YES")) {
                          controller.localResident = true;
                          controller.update();
                        } else if (str.contains("NO")) {
                          controller.localResident = false;
                          controller.update();
                        }
                        return null;
                      }, selected: controller.localResident),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: buildSlideableButton(
                          context, "Are you employed locally?", (str) {
                        if (str.contains("YES")) {
                          controller.employed = true;
                          controller.update();
                        } else if (str.contains("NO")) {
                          controller.employed = false;
                          controller.update();
                        }
                        return null;
                      }, selected: controller.employed),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildButton(context, "Submit",
                        () async => {await controller.signUp()})
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: AppTextStyle.buttonTextSelected,
                    ),
                    InkWell(
                        onTap: () {
                          controller.emailCont.clear();
                          controller.passCont.clear();
                          controller.landingcont.goToLogIn();
                        },
                        child: const Text(
                          " Log in",
                          style: AppTextStyle.buttonTextSelected,
                        )),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
