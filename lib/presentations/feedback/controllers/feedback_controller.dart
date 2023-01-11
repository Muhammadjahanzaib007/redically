import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/util/util.dart';
import '../../../data/repositories/feedback_repository.dart';

class FeedbackController extends GetxController {
  //TODO: Implement FeedbackController
  TextEditingController emailCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController messageCont = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode messageNode = FocusNode();
  final _repositry = FeedbackRepository();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  launchCaller(String tel) async {
    var url = Uri(
      scheme: 'tel',
      path: tel,
    );
    await launchUrl(url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchMail(String mail) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail,
    );
    await launchUrl(emailLaunchUri);
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  Future<void> submitFeedback() async {
    if (emailCont.text == "" || nameCont.text == "" || messageCont.text == "") {
      Utils.showSnackBar(title: "Alert", message: "Please Fill all Details");
    } else {
      loading.value = true;
      emailNode.unfocus();
      nameNode.unfocus();
      messageNode.unfocus();
      update();
      try {
        var resp = await _repositry.submitFeedback({
          "firstName": nameCont.text,
          "lastName": "",
          "email": emailCont.text,
          "message": messageCont.text
        });

        if (resp != null && resp['status'] == "Success") {
          loading.value = false;
          emailCont.clear();
          nameCont.clear();
          messageCont.clear();
          Utils.showDialog(
              msg: resp['message'],
              success: true,
              function: () {
                Get.back();
              });
        } else if (resp != null) {
          Utils.showSnackBar(
              message: resp['message'], title: 'Error', error: true);
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
}
