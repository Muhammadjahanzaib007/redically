
import 'package:get/get.dart';

import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class SearchRepository {
  late APIProvider apiClient;

  SearchRepository() {
    apiClient = APIProvider();
  }

  Future getProfiles({int? pageNumber, int? rows, String? search}) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getAllUsers}?searchName=$search&pageNumber=$pageNumber&rows=$rows",
        true,
        Get.context);
    return data;
  }

  Future getProfileById(String id) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getUserById}?UserId=$id", true, Get.context);
    return data;
  }

  Future getHomeVideos(String category, double? latitude, double? longitude,
      int pageNumber, int? rows, String? search) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getHomePageVideos}?${category == "" ? "" : "&Categories=$category"}${search == null ? "" : "&Search=$search"}&pageNumber=$pageNumber&rows=$rows${latitude == null ? "" : "&Latitude=$latitude&Longitude=$longitude"}",
        false,
        Get.context);
    return data;
  }

  Future followUnFollow(String id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.followUser}?toBeFollowUserId=$id",
        {},
        true,
        Get.context);
    return data;
  }

  Future followUnFollowRestaurant(String id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.followUnFollowRestaurant}?fsqId=$id",
        {},
        true,
        Get.context);
    return data;
  }

  Future saveUnSaveRestaurant(String id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${APIEndpoint.saveRestaurant}?fsqId=$id", {}, true, Get.context);
    return data;
  }

  Future createRestaurantCollection(
      String collectionName, String icon, List restaurants) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.createRestaurantCollection,
        {
          "collectionName": collectionName,
          "icon": icon,
          "restaurants": restaurants
        },
        true,
        Get.context);
    return data;
  }

  Future addRestaurantToCollection(List<int> restaurantIds, int id) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        APIEndpoint.addRestaurantToCollection,
        {"restaurantIds": restaurantIds, "collectionId": id},
        true,
        Get.context);
    return data;
  }

  Future getSavedRestaurantCollection(
    int pageNumber,
    int? rows,
  ) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getSavedRestaurantCollection}?PageNumber=$pageNumber&Row=$rows",
        true,
        Get.context);
    return data;
  }

  Future getRestaurants(
      {double? lat,
      double? long,
      String? query,
      int? radius,
      int? minPrice,
      int? maxPrice,
      bool? openNow,
      int? sortBy,
      int? limit,
      required String nextUrl,
      String? cusines}) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getRestaurants}?Lat=$lat&Lng=$long${query!.isEmpty ? "" : "&Query=$query"}&Radius=$radius&MinPrice=$minPrice&MaxPrice=$minPrice&OpenNow=$openNow&SortBy=$sortBy${cusines!.isEmpty ? "" : "&CusinesFilters=$cusines"}${nextUrl.isEmpty ? "" : "&nextUrl=$nextUrl"}${limit == null ? "" : "&limit=$limit"}",
        true,
        Get.context);
    return data;
  }

  Future getRestaurantById(String fsqId) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getRestaurantById}?fsqId=$fsqId", true, Get.context);
    return data;
  }

  Future getRestaurantVideosById(
      String fsqId, int pageNumber, int rows, String category) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getRestaurantVideos}?fsqId=$fsqId&PageNumber=$pageNumber&RowSize=$rows&category=$category",
        true,
        Get.context);
    return data;
  }

  Future getPlaylists(String search, int pageNumber, int row) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getAllPlaylists}?${search.isEmpty ? "" : "Search=$search&"}PageNumber=$pageNumber&Rows=$row",
        true,
        Get.context);
    return data;
  }

  Future getFeaturedBanners() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        APIEndpoint.getFeaturedBanners, true, Get.context);
    return data;
  }

  Future getAllVideos(String search, int pageNumber, int row, {id = 0}) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.getSearchPageVideos}?${search.isEmpty ? "" : "Search=$search&"}PageNumber=$pageNumber&Rows=$row&videoId=$id",
        true,
        Get.context);
    return data;
  }

  Future searchGeolocation(
    String search,
  ) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
        "${APIEndpoint.searchGeolocation}?${search.isEmpty ? "" : "query=$search"}",
        false,
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
