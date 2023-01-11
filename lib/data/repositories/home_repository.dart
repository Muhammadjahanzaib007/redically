import 'package:get/get.dart';

import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class HomeRepository {
  late APIProvider apiClient;

  HomeRepository() {
    apiClient = APIProvider();
  }

  Future getBalance() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.getBalance, true, Get.context);
    return data;
  }
}