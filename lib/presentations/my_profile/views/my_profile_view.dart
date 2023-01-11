import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:redically_local/app/config/app_colors.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/shared/shared_widgets.dart';
import '../../../app/util/util.dart';
import '../controllers/my_profile_controller.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
      progressIndicator: Image.asset(Utils.getImagePath('Scanner',format: 'gif',),color: AppColors.white,height: 150,width: 150,),
      inAsyncCall: controller.loading.value,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: buildAppBar(Text('My Profile',
            style: AppTextStyle.appBarTitle
                .copyWith(color: const Color(0xffA5CE71)))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifications",
                    style: AppTextStyle.mediumPeta.copyWith(fontSize: 18),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(value: true, onChanged: (e) {}),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              buildButton(
                  context, "Update Username", () => controller.updateUserName(),
                  height: 75,
                  width: double.infinity,
                  textStyle: AppTextStyle.mediumPeta
                      .copyWith(color: Colors.white, fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              buildButton(
                  context, "Update Password", () => controller.updatePassword(),
                  height: 75,
                  width: double.infinity,
                  textStyle: AppTextStyle.mediumPeta
                      .copyWith(color: Colors.white, fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              buildButton(context, "Log out", () => controller.logOut(),
                  height: 75,
                  width: double.infinity,
                  textStyle: AppTextStyle.mediumPeta
                      .copyWith(color: Colors.white, fontSize: 16)),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
