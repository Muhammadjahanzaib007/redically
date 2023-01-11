import 'dart:async';

import 'package:collection_ext/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/presentations/authentication/views/authentication_view.dart';
import 'package:redically_local/presentations/authentication/views/forgot_password_view.dart';
import 'package:redically_local/presentations/authentication/views/new_password_view.dart';
import 'package:redically_local/presentations/authentication/views/otp_verification.dart';
import 'package:redically_local/presentations/authentication/views/proof_ofresidency.dart';
import 'package:redically_local/presentations/authentication/views/upload_success_page.dart';
import 'package:redically_local/presentations/authentication/views/work_history_form_page.dart';
import 'package:redically_local/presentations/authentication/views/wrok_history_list_page.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/global_var.dart';
import '../../../app/routes/app_pages.dart';
import '../../authentication/views/sign_up_view.dart';

class LandingController extends GetxController {
  bool imageVisible = true;
  bool moveAside = false;
  IntRange trapezoidCount = const IntRange(0, 6);
  bool? localResident;
  bool? employed;
  bool clone = false;
  bool trapezoidClicked = false;
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController secondNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  Widget body = const SizedBox();
  Widget secondText = const Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.only(top: 100),
      child: Text(
        "Thank you for that information."
        " An e-mail confirmation has been sent your way."
        "\n\nYour local residency and work history is being validated."
        "\n\nThis will take no more than 24 hours."
        "\n\nKeep an eye out on your inbox for your Radically Local confirmation and personal QR code."
        "\n\nWhile you wait, can we share with you what we’re all about?",
        style: AppTextStyle.boldTextPara,
        textAlign: TextAlign.center,
      ),
    ),
  );

  bool isLogin = false;

  @override
  void onInit() {
    super.onInit();
  }

  startAnimation() async {
    if (Globals.authToken != "") {
      if (Globals.isLocalEmployed && !Globals.workHistoryStatus) {
        trapezoidCount = const IntRange(0, 5);
        imageVisible = false;
        trapezoidClicked = true;
        update();
        await Future.delayed(const Duration(seconds: 2));
        body = const WorkHistoryForm();
        moveAside = true;
        update();
      } else if (Globals.isLocalResident && !Globals.residenceProofStatus) {
        trapezoidCount = const IntRange(2, 4);
        imageVisible = false;
        trapezoidClicked = true;
        update();
        await Future.delayed(const Duration(seconds: 2));
        body = const ProofOfResidency();
        moveAside = true;
        update();
      } else {
        goToHome();
      }
    } else {
      trapezoidCount = const IntRange(1, 4);
      imageVisible = false;
      trapezoidClicked = true;
      update();
      isLogin = true;
      await Future.delayed(Duration(seconds: 2));
      body = const AuthenticationView();
      moveAside = true;
      update();
    }
  }

  startSecondAnimation() async {
    moveAside = false;
    body = SizedBox();
    update();
    await Future.delayed(Duration(seconds: 2));

    imageVisible = true;
    body = secondText;
    update();
    await Future.delayed(Duration(seconds: 2));

    clone = true;
    update();
  }

  goToHome() async {
    Get.toNamed(
      Routes.TriangleScreen,
    );
    await Future.delayed(const Duration(milliseconds: 1500));
    Get.offAllNamed(Routes.HOME);
    update();
  }

  goToLogIn() async {
    moveAside = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2500));

    trapezoidCount = IntRange(1, 4);
    update();
    await Future.delayed(const Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    isLogin = true;
    body = const AuthenticationView();
    update();
  }

  goToSuccessPage() async {
    moveAside = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));

    trapezoidCount = IntRange(2, 3);
    update();
    await Future.delayed(const Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    body = UploadSuccessPage();
    update();
  }

  goToResidenceProof() async {
    moveAside = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));

    trapezoidCount = IntRange(2, 4);
    update();
    await Future.delayed(const Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    body = ProofOfResidency();
    update();
  }

  goToOtpVerify(bool emailVerify) async {
    moveAside = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));

    trapezoidCount = IntRange(1, 3);
    update();
    await Future.delayed(Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    body = OtpVerificationView(
      EmailVerify: emailVerify,
    );
    update();
  }

  goToNewPass() async {
    moveAside = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));

    trapezoidCount = IntRange(1, 3);
    update();
    await Future.delayed(Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    body = NewPasswordPage();
    update();
  }

  goToForgotPass() async {
    moveAside = false;
    isLogin = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));

    trapezoidCount = IntRange(1, 3);
    update();
    await Future.delayed(Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    body = const ForgotPasswordPage();
    update();
  }

  goToWorkHistory() async {
    moveAside = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));

    trapezoidCount = const IntRange(0, 5);
    update();
    await Future.delayed(const Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    body = WorkHistoryForm();
    update();
  }

  goToWorkHistoryList() async {
    moveAside = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));

    trapezoidCount = IntRange(0, 2);
    update();
    await Future.delayed(const Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    body = WorkHistoryListPage();
    update();
  }

  goToSignUp() async {
    moveAside = false;
    isLogin = false;
    body = SizedBox();
    update();
    await Future.delayed(const Duration(seconds: 2));

    imageVisible = true;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));

    trapezoidCount = IntRange(0, 6);
    update();
    await Future.delayed(const Duration(milliseconds: 300));

    imageVisible = false;
    update();
    await Future.delayed(const Duration(seconds: 2));

    moveAside = true;
    body = SignUpView(
        // onclick: startSecondAnimation,
        // onlogin: goToLogIn,
        );
    update();
  }
}
