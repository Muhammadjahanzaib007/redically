import 'dart:io';
import 'package:get/get.dart';

import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class VideosRepository {
  late APIProvider apiClient;

  VideosRepository() {
    apiClient = APIProvider();
  }



  Future uploadFile(File file,
      {Function(int sent, int total)? progress}) async {
    Map<String, dynamic>? data = await apiClient.baseMultiPartAPI(
        APIEndpoint.uploadFileUrl, {}, false, Get.context, file,
        progress: progress);
    return data;
  }

  Future getProfile() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.getUserProfile, true, Get.context);
    return data;
  }

  Future getVideoById(int id) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getVideoById}?VideoId=$id", true, Get.context);
    return data;
  }

  Future deleteVideoById(int id) async {
    Map<String, dynamic> data = await apiClient.baseDeleteAPI(
        "${APIEndpoint.deleteVideos}?Ids=$id", {}, true, Get.context);
    return data;
  }

  Future getHomeVideos(String search, int pageNumber, int? rows,
      {List<String>? cuisines,
      int? price,
      String? latitude,
      String? longitude,
      // String? distance,
      bool? openNow,
      int? rating}) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getHomePageVideos}?Search=$search&pageNumber=$pageNumber&rows=$rows${cuisines == null || cuisines.isEmpty ? "" : "&Categories=${cuisines.join(",")}"}"
        "${latitude == null ? "" : "&Latitude=$latitude&Longitude=$longitude"}"
        "${price == null || price == 4 ? "" : "&Price=$price"}${rating == null || rating == 5 ? "" : "&Rating=$rating"}"
        //"${distance == null ? "" : "&Distance=$distance"}"
        "${openNow == null ? "&OpenNow=false" : "&OpenNow=$openNow"}",
        true,
        Get.context);
    return data;
  }

  Future postLikeDislike(int id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.postLikeDislike}?VideoId=$id", {}, true, Get.context);
    return data;
  }

  Future saveVideo(int id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.saveVideo}?VideoId=$id", {}, true, Get.context);
    return data;
  }

  Future addVideoToPlaylist(int playlistId, videoId) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.addVideoToPlaylist,
        {"playlistId": playlistId, "videoId": videoId},
        true,
        Get.context);
    return data;
  }

  Future addPlaylistToCollection(int collectionId, playlistId) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.addPlaylistToCollection,
        {
          "collectionId": collectionId,
          "playlistIds": [playlistId]
        },
        true,
        Get.context);
    return data;
  }

  Future createPlaylistCollection(
      String collectionName, String icon, List playlists) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.createPlaylistCollection,
        {
          "collectionName": collectionName,
          "icon": icon,
          "playlists": playlists
        },
        true,
        Get.context);
    return data;
  }

  Future getPlaylists(String ids, int pageNumber, int row) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getPlaylists}?${ids.isEmpty ? "" : "userId=$ids&"}PageNumber=$pageNumber&Rows=$row",
        true,
        Get.context);
    return data;
  }

  Future shareVideo(int id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.shareVideo}?VideoId=$id", {}, true, Get.context);
    return data;
  }

  Future likeComment(int id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.likeComment}?CommentId=$id", {}, true, Get.context);
    return data;
  }

  Future commentVideo(int id, String comment, int? parentCommentID) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.commentVideo,
        {"id": id, "comment": comment, "parentCommentID": parentCommentID ?? 0},
        true,
        Get.context);
    return data;
  }

  Future postShare(
    int id,
  ) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.postShare}?VideoId=$id", {}, true, Get.context);
    return data;
  }

  Future getUsersComments(int id, int pageNumber, int rows) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getUsersComments}?id=$id&pageNumber=$pageNumber&rows=$rows",
        true,
        Get.context);
    return data;
  }

  Future getMoreUsersComments(int id, int pageNumber, int rows) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getMoreUsersComments}?id=$id&pageNumber=$pageNumber&rows=$rows",
        true,
        Get.context);
    return data;
  }

  Future getRestaurants({
    double? lat,
    double? long,
    String? query,
  }) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getRestaurants}?${lat == null ? "" : "Lat=$lat&Lng=$long"}${query!.isEmpty ? "" : "&Query=$query"}&Radius=50000&MinPrice=1&MaxPrice=4",
        true,
        Get.context);
    return data;
  }

  Future getSavedPlaylistCollection(
    int pageNumber,
    int? rows,
  ) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getSavedPlaylistCollection}?PageNumber=$pageNumber&Row=$rows",
        true,
        Get.context);
    return data;
  }

  Future getHubConnection() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.negotiateUrl, false, Get.context,
        fullUrl: APIEndpoint.negotiateUrl);
    return data;
  }

  Future getDeepLink({required String pageUrl}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "",
        {
          "longDynamicLink":
              "${APIEndpoint.dynamicLinkPrefix}?link=$pageUrl&${APIEndpoint.dynamicLinkPostfix}&ifl=${APIEndpoint.foodleWebsite}",
          "suffix": {"option": "UNGUESSABLE"}
        }
        /*{
          "longDynamicLink":
              "${APIEndpoint.dynamicLinkPrefix}?${APIEndpoint.dynamicLinkPostfix}",
        }*/
        ,
        false,
        Get.context,
        fullUrl: APIEndpoint.createDeepLink);
    return data;
  }
}
