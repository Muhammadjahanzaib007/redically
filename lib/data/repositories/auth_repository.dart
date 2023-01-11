import 'dart:io';

import 'package:get/get.dart';

import '../../app/config/global_var.dart';
import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class AuthRepository {
  late APIProvider apiClient;

  AuthRepository() {
    apiClient = APIProvider();
  }

  Future signUp(
      {required String? pass,
      required String? firstName,
      required String? lastName,
      required String? email,
      required bool? isLocal,
      required bool? isEmployed}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.signUpUrl,
        {
          "id": "",
          "password": pass,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "isLocalResident": isLocal,
          "isEmployedLocally": isEmployed
        },
        false,
        Get.context);
    return data;
  }

  // Future updateProfile(UserProfile userProfile) async {
  //   Map<String, dynamic> data = await apiClient.basePostAPI(
  //       APIEndpoint.updateProfileUrl,
  //       {
  //         if (userProfile.id != null) "id": userProfile.id!,
  //         if (userProfile.firstName != null)
  //           "firstName": userProfile.firstName!,
  //         if (userProfile.lastName != null) "lastName": userProfile.lastName!,
  //         if (userProfile.dateOfBirth != null)
  //           "dateOfBirth": userProfile.dateOfBirth!,
  //         if (userProfile.gender != null) "gender": userProfile.gender!,
  //         if (userProfile.bio != null) "bio": userProfile.bio!,
  //         if (userProfile.bioDetail != null)
  //           "bioDetail": userProfile.bioDetail!,
  //         if (userProfile.socilaLink != null)
  //           "socilaLink": userProfile.socilaLink!,
  //         if (userProfile.photo != null) "photo": userProfile.photo!
  //       },
  //       false,
  //       Get.context);
  //   return data;
  // }
  //
  Future login(
      String email, pass, fcmToken, loginDevice, deviceId, appVersion) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
        APIEndpoint.loginUrl,
        {
          "email": email,
          "password": pass,
          "fcmToken": fcmToken,
          "loginDevice": loginDevice,
          "deviceId": deviceId,
          "appVersion": appVersion
        },
        false,
        Get.context);
    return data;
  }

  Future forgetPassword(String username) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.forgetPasswordUrl}?username=${username.replaceAll("@", "%40")}",
        {},
        false,
        Get.context);
    return data;
  }

  Future verifyFrgtPassOtp(String otp) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.verifyForgetPasswordOtp}?OTP=$otp", false, Get.context);
    return data;
  }

  Future verifyEmail(Map<String, dynamic> body) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
        APIEndpoint.verifyEmailUrl, body, false, Get.context);
    return data;
  }

  // Future verifyPhone(Map<String, dynamic> body) async {
  //   Map<String, dynamic>? data = await apiClient.basePostAPI(
  //       APIEndpoint.verifyPhoneUrl, body, false, Get.context);
  //   return data;
  // }

  Future resendVerificationEmail(String email, String? id) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        "${APIEndpoint.resendVerifyEmailUrl}?email=$email&id=${id}",
        false,
        Get.context);
    return data;
  }

  // Future resendVerificationSms(String phone) async {
  //   Map<String, dynamic>? data = await apiClient.baseGetAPI(
  //       "${APIEndpoint.resendVerifySmsUrl}?phoneNumber=$phone&id=${Globals.userId}",
  //       false,
  //       Get.context);
  //   return data;
  // }

  Future updateForgotPassword(Map<String, dynamic> body) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
        APIEndpoint.updateForgetPasswordUrl, body, false, Get.context);
    return data;
  }

  Future updatePassword(Map<String, dynamic> body) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
        APIEndpoint.changePassword, body, true, Get.context);
    return data;
  }

  Future updateUser(Map<String, dynamic> body) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
        APIEndpoint.updateCustomer, body, true, Get.context);
    return data;
  }

  Future uploadImage(File file) async {
    Map<String, dynamic>? data = await apiClient.baseMultiPartAPI(
        APIEndpoint.uploadFileUrl, {}, false, Get.context, file);
    return data;
  }

  Future checkUserName(String userName) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        "${APIEndpoint.checkUserName}?name=$userName", false, Get.context);
    return data;
  }

  Future refreshToken() async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
        APIEndpoint.refreshTokenUrl,
        {
          "refreshToken": Globals.refreshToken,
          "fcmToken": "string",
          "loginDevice": "string",
          "appVersion": "string"
        },
        false,
        Get.context);
    return data;
  }

  Future saveWorkHistory({
    required String company,
    required String role,
    required String address,
    required String startDate,
  }) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.saveWorkHistory,
        {
          "companyName": company,
          "role": role,
          "address": address,
          "startDate": startDate,
        },
        true,
        Get.context);
    return data;
  }

  Future getWorkHistory() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.getWorkHistory, true, Get.context);
    return data;
  }
}
