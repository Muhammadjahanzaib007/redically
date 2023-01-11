
import 'package:get/get.dart';

import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class ChatsRepository {
  late APIProvider apiClient;

  ChatsRepository() {
    apiClient = APIProvider();
  }



  Future toggleChatMuteNotification(bool mute, String fromUserId) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.toggleChatMuteNotification}?Mute=$mute&UserId=$fromUserId",
        {},
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

  Future getChatHistory(
    String search,
    int pageNumber,
    int? rows,
  ) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getChatHistory}?search=$search&PageNumber=$pageNumber&Rows=$rows",
        true,
        Get.context);
    return data;
  }

  Future getChatMuteNotification(
    String userId,
  ) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getChatMuteNotification}?UserId=$userId",
        true,
        Get.context);
    return data;
  }

  Future getMessages(
    int userId,
    int pageNumber,
    int? rows,
  ) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getMessages}?ConversationId=$userId&PageNumber=$pageNumber&Rows=$rows",
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

  Future sendMessage(String toUserId, String text) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.sendMessage,
        {"toUserId": toUserId, "text": text},
        true,
        Get.context);
    return data;
  }

  Future reportUser(String foodleUserName, String text) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.reportUser,
        {"foodleUserName": foodleUserName, "text": text},
        true,
        Get.context);
    return data;
  }

  Future blockUser(String userId) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.blockUser}?UserId=$userId", true, Get.context);
    return data;
  }

  Future deleteConversation(int conversationId) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.deleteConversation}?ConversationId=$conversationId",
        true,
        Get.context);
    return data;
  }
}
