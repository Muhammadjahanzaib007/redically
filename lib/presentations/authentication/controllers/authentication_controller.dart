import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/app/config/app_string.dart';
import 'package:redically_local/data/repositories/auth_repository.dart';
import 'package:redically_local/presentations/landing/controllers/landing_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/config/global_var.dart';
import '../../../app/util/util.dart';
import '../../../data/models/work_history.dart';
import '../../../data/providers/local_storage/local_db.dart';

class AuthenticationController extends GetxController {
  bool? localResident;
  bool? employed;
  RxBool loading = false.obs;
  RxBool buttonEnable = true.obs;
  SharedPreferences? prefs;
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController secondNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController confirmpassCont = TextEditingController();
  TextEditingController otpCont = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  DateTime? startDate;
  FocusNode nameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passNode = FocusNode();
  FocusNode confirmpassNode = FocusNode();
  FocusNode otpNode = FocusNode();
  FocusNode companyNameNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode roleNode = FocusNode();
  final LandingController landingcont = Get.put(LandingController());
  String? userId;
  File? fileresults;
  List<WorkHistory> workhistoryList = [];
  final authRepo = AuthRepository();
  late int count;
  late Timer timer;
  int secondsRemaining = 0;
  bool enableResend = false;
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining--;
        update();
      } else {
        enableResend = true;
        update();
      }
    });
    super.onInit();
  }

  Future pickImage() async {
    fileresults = await Utils.getImageFromGallery();
    update();
  }

  Future<void> signUp() async {
    if (firstNameCont.text == "" ||
        emailCont.text == "" ||
        passCont.text == "" ||
        confirmpassCont.text == "" ||
        localResident == null ||
        employed == null) {
      Utils.showSnackBar(title: "Alert", message: "Please fill all details");
    } else if (passCont.text != confirmpassCont.text) {
      Utils.showSnackBar(
          title: "Alert", message: "Your password does not match");
    } else if (localResident == false && employed == false) {
      Utils.showSnackBar(
          title: "Alert",
          message:
              "You should be a local resident or locally employed in order to register.");
    } else {
      nameNode.unfocus();
      emailNode.unfocus();
      passNode.unfocus();
      confirmpassNode.unfocus();
      try {
        var resp = await authRepo.signUp(
          pass: passCont.text,
          isLocal: localResident,
          firstName: firstNameCont.text,
          lastName: secondNameCont.text,
          email: emailCont.text,
          isEmployed: employed,
        );
        print(resp);
        if (resp['message'].toString().contains("User Already Exist")) {
          secondsRemaining = 60;
          enableResend = false;
          loading.value = false;
          userId = resp['payload'];
          update();
          landingcont.goToOtpVerify(true);
        } else {
          if (resp != null && resp['status'] != "Fail") {
            secondsRemaining = 60;
            enableResend = false;
            loading.value = false;
            userId = resp['payload']['id'];
            update();
            landingcont.goToOtpVerify(true);
          } else {
            Utils.showSnackBar(
                message: "${resp['message']}",
                title: resp['payload']['errors'][0]['code'] ?? "Error",
                error: true);
            loading.value = false;
          }
        }

        update();
      } catch (e) {
        loading.value = false;
        Get.log('AuthController.signUp catch error of : $e');
      }
    }
  }

  Future<void> verifyEmail() async {
    if (otpCont.text == "") {
      Utils.showSnackBar(title: "Alert", message: "Please Enter OTP");
    } else {
      otpNode.unfocus();
      try {
        loading.value = true;
        var resp = await authRepo.verifyEmail(
            {"id": userId, "email": emailCont.text, "token": otpCont.text});
        if (resp != null && resp['status'] != "Fail") {
          otpCont.clear();
          Get.log('AuthController.verifyEmail  $resp');
          await saveData(resp);

          if (resp['payload']['isApproved']) {
            checkProofStatus();
          } else {
            landingcont.startSecondAnimation();
          }
        } else if (resp != null) {
          Utils.showSnackBar(message: resp['message'], title: '', error: true);
        } else {}

        loading.value = false;
        update();
      } catch (e) {
        loading.value = false;
        update();
        Get.log('AuthController.verifyEmail$e');
      }
    }
  }

  Future<void> signIn() async {
    if (emailCont.text == "" || passCont.text == "") {
      Utils.showSnackBar(title: "Alert", message: "Please fill all details");
    } else {
      emailNode.unfocus();
      passNode.unfocus();
      try {
        loading.value = true;
        var resp = await authRepo.login(emailCont.text, passCont.text,
            "fcmToken", "loginDevice", "deviceId", "appVersion");
        Get.log('AuthController.signIn $resp');
        print('AuthController.signIn $resp');
        if (resp != null && resp['status'] == "Success") {
          loading.value = false;
          Globals.email = emailCont.text;
          Get.log('AuthController.signIn ${resp['token']}');
          passCont.clear();
          emailCont.clear();
          await saveData(resp);
          landingcont.isLogin = false;
          landingcont.update();
          if (resp['payload']['isApproved']) {
            checkProofStatus();
          } else {
            landingcont.startSecondAnimation();
          }
        } else if (resp != null) {
          if (resp["errorCode"] == 2) {
            userId = resp['payload']['id'];
            // resendVerificationEmail(userId!, emailController.text);
          } else {
            Utils.showSnackBar(
                message: resp['message'], title: '', error: true);
          }
        } else {}
        loading.value = false;
        update();
      } catch (e) {
        loading.value = false;
        update();
        print("linkdlnSigin=$e");
      }
    }
  }

  Future<void> forgotPassword() async {
    if (emailCont.text == "") {
      Utils.showSnackBar(title: "Alert", message: "Please Enter your Email");
    } else {
      emailNode.unfocus();
      try {
        loading.value = true;
        var resp = await authRepo.forgetPassword(emailCont.text);

        if (resp != null && resp['status'] == "Success") {
          Utils.showSnackBar(title: "", message: resp['message'], error: false);
          secondsRemaining = 60;
          enableResend = false;
          landingcont.update();
          landingcont.goToOtpVerify(false);
        } else if (resp != null) {
          Utils.showSnackBar(message: resp['message'], title: '', error: true);
        } else {}

        loading.value = false;
        update();
      } catch (e) {
        loading.value = false;
        update();
        print("linkdlnSigin=$e");
      }
    }
  }

  Future<void> verifyFrgtPassOtp() async {
    if (otpCont.text == "") {
      Utils.showSnackBar(title: "Alert", message: "Please Enter OTP");
    } else {
      otpNode.unfocus();
      try {
        loading.value = true;
        var resp = await authRepo.verifyFrgtPassOtp(otpCont.text);

        if (resp != null && resp['status'] == "Success") {
          Utils.showSnackBar(title: "", message: resp['message'], error: false);
          landingcont.update();
          landingcont.goToNewPass();
        } else if (resp != null) {
          Utils.showSnackBar(message: resp['message'], title: '', error: true);
        } else {}

        loading.value = false;
        update();
      } catch (e) {
        loading.value = false;
        update();
        print("linkdlnSigin=$e");
      }
    }
  }

  Future<void> saveWorkHistory() async {
    if (companyController.text == "" ||
        roleController.text == "" ||
        adressController.text == "" ||
        startDate == null) {
      Utils.showSnackBar(title: "Alert", message: "Please Fill all Details");
    } else {
      companyNameNode.unfocus();
      roleNode.unfocus();
      addressNode.unfocus();
      try {
        var resp = await authRepo.saveWorkHistory(
          company: companyController.text,
          role: roleController.text,
          address: adressController.text,
          startDate: startDate?.toIso8601String() ?? "",
        );
        print(resp);
        if (resp != null && resp['status'] != "Fail") {
          companyController.clear();
          roleController.clear();
          adressController.clear();
          landingcont.goToWorkHistoryList();
          LocalDB.setData(AppStrings.workHistoryStatus, true);
          Globals.workHistoryStatus = true;
          getWorkHistory();
          loading.value = false;
          update();
        } else {
          Utils.showSnackBar(
              message: "${resp['message']}", title: '', error: true);
          loading.value = false;
        }
        update();
      } catch (e) {
        loading.value = false;
        Get.log('Save work history error of try catch : $e');
      }
    }
  }

  Future<void> saveResidenceProof() async {
    try {
      if (fileresults != null) {
        var resp = await authRepo.uploadImage(fileresults!);
        print(resp);
        if (resp != null && resp['status'] != "Fail") {
          Map<String, dynamic> body = {
            "residencyProof": resp['payload'].toString()
          };
          final response = await authRepo.updateUser(body);
          if (response != null && response['status'] != "Fail") {
            LocalDB.setData(AppStrings.residenceProofStatus, true);
            Globals.residenceProofStatus = true;
            if (Globals.isLocalEmployed && !Globals.workHistoryStatus) {
              landingcont.goToWorkHistory();
            } else {
              landingcont.goToHome();
            }
          }

          loading.value = false;
          update();
        } else {
          Utils.showSnackBar(
              message: "${resp['message']}", title: '', error: true);
          loading.value = false;
        }
        update();
      }
    } catch (e) {
      loading.value = false;
      Get.log('Save residence prooferror of try catch : $e');
    }
  }

  Future<void> updateForgotPassword() async {
    if (passCont.text == "") {
      Utils.showSnackBar(
          title: "Alert", message: "Please Enter Your New Password");
    } else {
      passNode.unfocus();
      try {
        Map<String, dynamic> body = {
          "userName": emailCont.text,
          "password": passCont.text,
          "token": otpCont.text + "23",
        };
        print(body);
        var resp = await authRepo.updateForgotPassword(body);
        print(resp);
        if (resp != null && resp['status'] != "Fail") {
          firstNameCont.clear();
          passCont.clear();
          emailCont.clear();
          Utils.showSnackBar(
            message: "${resp['message']}",
            title: '',
            error: false,
          );
          landingcont.goToLogIn();
          loading.value = false;
          update();
        } else {
          Utils.showDialog(
              msg: resp['message'],
              buttonText: "Resend",
              function: () async {
                landingcont.goToOtpVerify(false);
                forgotPassword();
              });
          loading.value = false;
        }
        update();
      } catch (e) {
        Utils.showDialog(
            msg: 'Some Error Occur',
            buttonText: "Resend",
            function: () async {
              landingcont.goToOtpVerify(false);
              await forgotPassword();
            });
        loading.value = false;
        Get.log('forgot pass error of try catch : $e');
      }
    }
  }

  Future<void> resendOtp() async {
    otpNode.unfocus();
    try {
      var resp = await authRepo.resendVerificationEmail(emailCont.text, userId);
      print(resp);
      if (resp != null && resp['status'] != "Fail") {
        Utils.showSnackBar(
            message: "${resp['message']}", title: '', error: false);
        secondsRemaining = 60;
        enableResend = false;
        loading.value = false;
        update();
      } else {
        loading.value = false;
      }
      update();
    } catch (e) {
      loading.value = false;
      Get.log('Save work history error of try catch : $e');
    }
  }

  Future<void> getWorkHistory() async {
    try {
      var resp = await authRepo.getWorkHistory();

      if (resp != null && resp['status'] != "Fail") {
        workhistoryList = [];
        resp['payload'].forEach((v) {
          workhistoryList.add(WorkHistory.fromJson(v));
        });
        loading.value = false;
        update();
      } else {
        Utils.showSnackBar(
            message: "${resp['message']}", title: '', error: true);
        loading.value = false;
      }
      update();
    } catch (e) {
      loading.value = false;
      Get.log('Save work history error of try catch : $e');
    }
  }

  Future<void> refreshToken() async {
    try {
      update();

      var body = await authRepo.refreshToken();
      if (body["errorCode"] == 0) {
        saveData(body);
      }

      update();
    } catch (e) {
      update();
      print("refresh token =$e");
    }
  }

  Future<void> saveData(response) async {
    var body = response;

    if (body['status'] == 'Success') {
      if (body['payload']['isApproved']) {
        LocalDB.setData(
            AppStrings.token, body['payload']['token']['tokenString']);
        LocalDB.setData(AppStrings.userId, body['payload']['id']);
        LocalDB.setData(
            AppStrings.refreshToken, body['payload']['token']['refreshToken']);
        LocalDB.setData(AppStrings.email, body['payload']['email']);
        LocalDB.setData(AppStrings.name, body['payload']['firstName']);
        LocalDB.setData(
            AppStrings.isLocalEmployed, body['payload']['isEmployedLocally']);
        LocalDB.setData(
            AppStrings.isLocalResident, body['payload']['isLocalResident']);
        LocalDB.setData(AppStrings.residenceProofStatus,
            body['payload']['residencyProofUploaded']);
        LocalDB.setData(AppStrings.workHistoryStatus,
            body['payload']['workHistoryUploaded']);
        update();
      }
      Globals.name = body['payload']['firstName'];
      Globals.email = body['payload']['email'];
      Globals.userId = body['payload']['id'];
      Globals.authToken = body['payload']['token']['tokenString'];
      Globals.refreshToken = body['payload']['token']['refreshToken'];
      Globals.isLocalResident = body['payload']['isLocalResident'];
      Globals.isLocalEmployed = body['payload']['isEmployedLocally'];
      Globals.residenceProofStatus = body['payload']['residencyProofUploaded'];
      Globals.workHistoryStatus = body['payload']['workHistoryUploaded'];
    } else {
      Get.back();
    }
  }

  void checkProofStatus() {
    if (Globals.isLocalEmployed && !Globals.workHistoryStatus) {
      landingcont.goToWorkHistory();
    } else if (Globals.isLocalResident && !Globals.residenceProofStatus) {
      landingcont.goToResidenceProof();
    } else {
      landingcont.goToHome();
    }
  }

  void showDialog(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 280,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }
}
