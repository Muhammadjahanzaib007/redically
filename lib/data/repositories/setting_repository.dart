import 'package:get/get.dart';

import '../../app/config/global_var.dart';
import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class SettingRepository {
  late APIProvider apiClient;

  SettingRepository() {
    apiClient = APIProvider();
  }

  // Future updateProfile(UserProfile userProfile) async {
  //   Map<String, dynamic> data = await apiClient.basePostAPI(
  //       APIEndpoint.updateProfileUrl,
  //       {
  //         "id": userProfile.id!,
  //         if (userProfile.photo != null) "photo": userProfile.photo!,
  //         if (userProfile.firstName != null)
  //           "firstName": userProfile.firstName!,
  //         if (userProfile.lastName != null) "lastName": userProfile.lastName!,
  //         if (userProfile.bio != null) "bio": userProfile.bio!,
  //         if (userProfile.bioDetail != null)
  //           "bioDetail": userProfile.bioDetail!,
  //         if (userProfile.dateOfBirth != null)
  //           "dateOfBirth": userProfile.dateOfBirth!,
  //         if (userProfile.gender != null) "gender": userProfile.gender!,
  //         if (userProfile.socilaLink != null)
  //           "socilaLink": userProfile.socilaLink!
  //       },
  //       true,
  //       Get.context);
  //   return data;
  // }

  Future getProfile() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.getUserProfile, true, Get.context);
    return data;
  }

  Future forgetPassword(String username) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.forgetPasswordUrl}?username=$username",
        {},
        false,
        Get.context);
    return data;
  }

  Future updatePassword(Map<String, dynamic> body) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
        APIEndpoint.updateForgetPasswordUrl, body, false, Get.context);
    return data;
  }

  Future verifyForgetPasswordOtp(String otp) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        "${APIEndpoint.verifyForgetPasswordOtp}?OTP=$otp", false, Get.context);
    return data;
  }

  Future resendVerificationEmail(String email) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        "${APIEndpoint.resendVerifyEmailUrl}?email=$email&id=${Globals.userId}",
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

  Future getGeneralNotifications() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.getGeneralNotifications, true, Get.context);
    return data;
  }

  Future getEmailNotifications() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.getEmailNotifications, true, Get.context);
    return data;
  }

  Future getBlockedUsers({int? pageNumber, int? rows, String? search}) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getBlockedUsers}?pageNumber=$pageNumber&rows=$rows",
        true,
        Get.context);
    return data;
  }

  Future blockUser(String userId) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.blockUser}?UserId=$userId", true, Get.context);
    return data;
  }

/*  Future toggleGeneralNotifications(Notifications notifications) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.toggleGeneralNotifications,
        {
          "enableNotifications": notifications.enableNotifications,
          "posts": notifications.posts,
          "comments": notifications.comments,
          "followingAndFollowers": notifications.followingAndFollowers,
          "messages": notifications.messages,
          "foodle": notifications.foodle
        },
        true,
        Get.context);
    return data;
  }

  Future toggleEmailNotifications(Notifications notifications) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.toggleEmailNotifications,
        {
          "foodleUpdatesEmail": notifications.foodleUpdatesEmail,
          "newsEmail": notifications.newsEmail,
          "feedbackEmails": notifications.feedbackEmails
        },
        true,
        Get.context);
    return data;
  }*/

  Future closeAccount(String password) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.closeAccount}?Password=$password",
        {},
        true,
        Get.context);
    return data;
  }
}
