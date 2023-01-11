import 'package:get/get.dart';

import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class FeedbackRepository {
  late APIProvider apiClient;

  FeedbackRepository() {
    apiClient = APIProvider();
  }

  Future submitFeedback(Map<String, dynamic> body) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
        APIEndpoint.postFeedback, body, true, Get.context);
    return data;
  }
}
