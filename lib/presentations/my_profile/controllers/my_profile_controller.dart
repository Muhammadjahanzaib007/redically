import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/app/routes/app_pages.dart';
import 'package:redically_local/app/util/util.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_string.dart';
import '../../../app/config/global_var.dart';
import '../../../app/shared/shared_widgets.dart';
import '../../../data/providers/local_storage/local_db.dart';
import '../../../data/repositories/auth_repository.dart';

class MyProfileController extends GetxController {
  TextEditingController usernameCont = TextEditingController();
  TextEditingController previousPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();
  FocusNode userNameNode = FocusNode();
  FocusNode oldpassNode = FocusNode();
  FocusNode newpassNode = FocusNode();
  FocusNode confirmpassNode = FocusNode();
  final authRepo = AuthRepository();
  RxBool loading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  updateUserName() {
    Get.defaultDialog(
        titlePadding: EdgeInsets.symmetric(vertical: 25),
        title: "Update Username",
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 200,
          width: Get.width - 20,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTextFeild(
                    Get.context!, "Enter new Name", usernameCont, userNameNode,
                    controller: MyProfileController(),
                    height: 60,
                    hintStyle: AppTextStyle.regularPeta.copyWith(fontSize: 13)),
                buildButton(
                  Get.context!,
                  "update",
                  () {
                    if (usernameCont.text.isEmpty || usernameCont.text == "")
                      {
                        Utils.showSnackBar(
                            title: "", message: "Please Fill Username", error: false);
                      }
                    else {
                      updateName();
                    }
                  },
                  height: 40,
                  width: 150,
                  textStyle: AppTextStyle.regularPeta
                      .copyWith(color: Colors.white, fontSize: 12),
                )
              ]),
        ));
  }

  updatePassword() {
    Get.defaultDialog(
        titlePadding: EdgeInsets.symmetric(vertical: 25),
        title: "Update Password",
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTextFeild(Get.context!, "Enter Old Password", previousPass,
                    oldpassNode,
                    controller: MyProfileController(),
                    obscure: true,
                    height: 60,
                    width: double.infinity,
                    hintStyle: AppTextStyle.regularPeta.copyWith(fontSize: 13)),
                const SizedBox(
                  height: 20,
                ),
                buildTextFeild(
                    Get.context!, "Enter New Password", newPass, newpassNode,
                    controller: MyProfileController(),
                    height: 60,
                    obscure: true,
                    width: double.infinity,
                    hintStyle: AppTextStyle.regularPeta.copyWith(fontSize: 13)),
                const SizedBox(
                  height: 20,
                ),
                buildTextFeild(Get.context!, "Confirm New Password",
                    confirmNewPass, confirmpassNode,
                    controller: MyProfileController(),
                    height: 60,
                    obscure: true,
                    width: double.infinity,
                    hintStyle: AppTextStyle.regularPeta.copyWith(fontSize: 13)),
                const SizedBox(
                  height: 20,
                ),
                buildButton(
                  Get.context!,
                  "update",
                  () {
                    if (previousPass.text.isEmpty || newPass.text.isEmpty || confirmNewPass.text.isEmpty)
                    {
                      Utils.showSnackBar(
                          title: "", message: "Please Fill Fields", error: false);
                    }
                    else {
                      updatePass();
                    }
                    },
                  height: 40,
                  width: 150,
                  textStyle: AppTextStyle.regularPeta
                      .copyWith(color: Colors.white, fontSize: 12),
                )
              ]),
        ));
  }

  Future<void> updateName() async {
    try {
      Map<String, dynamic> body = {
        "firstName": usernameCont.text,
      };
      Get.back();
      loading.value = true;
      update();
      final response = await authRepo.updateUser(body);
      if (response != null && response['status'] != "Fail") {
        LocalDB.setData(AppStrings.name, usernameCont.text);
        Globals.name = usernameCont.text;
        usernameCont.clear();
        update();
        loading.value = false;
        Get.toNamed(Routes.HOME);
        Utils.showSnackBar(
            title: "", message: response['message'], error: false);
      } else {
        Utils.showSnackBar(
            title: "", message: response['message'], error: true);
      }

      update();
    } catch (e) {
      loading.value = false;
      update();
      Get.log('Save work history error of try catch : $e');
    }
  }

  Future<void> updatePass() async {
    try {
      Map<String, dynamic> body = {
        "oldPassword": previousPass.text,
        "newPassword": newPass.text,
        "confirmPassword": confirmNewPass.text,
        "current": true
      };
      Get.back();
      loading.value = true;
      update();
      final response = await authRepo.updatePassword(body);
      if (response != null && response['status'] != "Fail") {
        newPass.clear();
        previousPass.clear();
        confirmNewPass.clear();
        update();
        loading.value = false;
        Get.toNamed(Routes.HOME);
        Utils.showSnackBar(
            title: "", message: response['message'], error: false);
      } else {
        Utils.showSnackBar(
            title: "", message: response['message'], error: true);
      }

        update();
      } catch (e) {
        loading.value = false;
        update();
        Get.log('Save work history error of try catch : $e');
      }
    }

  logOut() {
    LocalDB.clear();
    Get.offAllNamed(Routes.LANDING);
  }
}
