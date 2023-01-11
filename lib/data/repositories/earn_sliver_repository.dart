import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class EarnSilverRepository {
  late APIProvider apiClient;

  EarnSilverRepository() {
    apiClient = APIProvider();
  }
  Future getAllCategoriesByPagination() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.getAllCategory, true, Get.context);
    return data;
  }

  Future getAllBusinessesByPagination(
      int? id, String? businessName, int pageNumber, int rows) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getAllBusiness}?categoryId=${id ?? ""}&page=$pageNumber&size=$rows&Search=${businessName ?? ""}",
        true,
        Get.context);
    return data;
  }

  Future getBusinessWithOffer(int? id, int pageNumber, int rows) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getBusinessDetail}?Bid=${id ?? ""}&page=$pageNumber&size=$rows",
        true,
        Get.context);
    return data;
  }

  Future getAllEventByDates(DateTime? startDate, DateTime? endDate) async {
    late String url;
    if (startDate != null && endDate != null) {
      url =
          "${APIEndpoint.getAllEvents}?EventStartDate=${DateFormat("yyyy-MM-dd").format(startDate)}&EventEndDate=${DateFormat("yyyy-MM-dd").format(endDate)}";
    } else {
      url = APIEndpoint.getAllEvents;
    }
    Map<String, dynamic> data =
        await apiClient.baseGetAPI(url, true, Get.context);
    return data;
  }
}
