import 'package:get/get.dart';

import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class ProfileRepository {
  late APIProvider apiClient;

  ProfileRepository() {
    apiClient = APIProvider();
  }

  // Future updateProfile(UserProfile userProfile) async {
  //   Map<String, dynamic> data = await apiClient.basePostAPI(
  //       APIEndpoint.updateProfileUrl,
  //       {
  //         "id": userProfile.id!,
  //         if (userProfile.userName != null)
  //           "foodleUserName": userProfile.foodleUserName!,
  //         if (userProfile.photo != null) "photo": userProfile.photo!,
  //         if (userProfile.bio != null) "bio": userProfile.bio!,
  //         if (userProfile.bioDetail != null)
  //           "bioDetail": userProfile.bioDetail!,
  //         if (userProfile.dateOfBirth != null)
  //           "dateOfBirth": userProfile.dateOfBirth!,
  //         if (userProfile.gender != null) "gender": userProfile.gender!,
  //         if (userProfile.socilaLink != null)
  //           "socialLink": userProfile.socilaLink!,
  //         if (userProfile.socilaLink != null)
  //           "firstName": userProfile.firstName!,
  //         if (userProfile.socilaLink != null) "lastName": userProfile.lastName!
  //       },
  //       true,
  //       Get.context);
  //   return data;
  // }

  Future getProfile(String? id) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        id != null
            ? "${APIEndpoint.getUserById}?UserId=$id"
            : APIEndpoint.getUserProfile,
        true,
        Get.context);
    return data;
  }

  Future followUnfollowUser(String? id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.followUser}?toBeFollowUserId=$id",
        {},
        true,
        Get.context);
    return data;
  }

  Future getProfileVideos(
      String? id, int pageNumber, int? rows, bool Ispublished) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getAllVideos}?UserId=$id&pageNumber=$pageNumber&rows=$rows&Ispublished=$Ispublished",
        true,
        Get.context);
    return data;
  }

  Future getPlaylistVideos(
    String? id,
    int pageNumber,
    int? rows,
  ) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getPlaylistVideos}?PlaylistId=$id&pageNumber=$pageNumber&row=$rows",
        true,
        Get.context);
    return data;
  }

  Future getProfileFollowers(String userId, String status, int pageNumber,
      int? rows, String? search) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getFollowers}?UserId=$userId&status=$status&pageNumber=$pageNumber&rows=$rows",
        true,
        Get.context);
    return data;
  }

  Future blockUser(String userId) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.blockUser}?UserId=$userId", true, Get.context);
    return data;
  }
  // Future UnblockUser(String userId) async {
  //   Map<String, dynamic> data = await apiClient.baseGetAPI(
  //       "${APIEndpoint.blockUser}?UserId=$userId", false, Get.context);
  //   return data;
  // }

  Future reportUser(String foodleUserName, String text) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.reportUser,
        {"foodleUserName": foodleUserName, "text": text},
        true,
        Get.context);
    return data;
  }

  Future deleteVideos(
    String ids,
  ) async {
    Map<String, dynamic> data = await apiClient.baseDeleteAPI(
        "${APIEndpoint.deleteVideos}?Ids=$ids", {}, true, Get.context);
    return data;
  }

  Future deleteNotifications(
    String ids,
  ) async {
    Map<String, dynamic> data = await apiClient.baseDeleteAPI(
        "${APIEndpoint.deleteNotifications}?Ids=$ids", {}, true, Get.context);
    return data;
  }

  Future getVideoById(int id) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getVideoById}?VideoId=$id", true, Get.context);
    return data;
  }

  Future getPlaylists(String ids, int pageNumber, int row) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getPlaylists}?${ids.isEmpty ? "" : "userId=$ids&"}PageNumber=$pageNumber&Rows=$row",
        true,
        Get.context);
    return data;
  }

  Future getNotifications(int pageNumber, int row) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getNotifications}?PageNumber=$pageNumber&Rows=$row",
        true,
        Get.context);
    return data;
  }

  Future getDeepLink({required String pageUrl}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "",
        {
          "longDynamicLink":
              "${APIEndpoint.dynamicLinkPrefix}?link=$pageUrl&${APIEndpoint.dynamicLinkPostfix}",
        },
        false,
        Get.context,
        fullUrl: APIEndpoint.createDeepLink);
    return data;
  }
}
