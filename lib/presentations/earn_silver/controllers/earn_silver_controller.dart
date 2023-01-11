import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_carousel/classes/multiple_marked_dates.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redically_local/data/models/business_detail_model.dart';
import 'package:redically_local/data/models/business_model.dart';
import 'package:redically_local/data/repositories/earn_sliver_repository.dart';

import '../../../app/util/util.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/getAllEvents_model.dart';

class EarnSilverController extends GetxController {
  final EarnSilverRepository _repository = EarnSilverRepository();
  List<Category> categories = [];
  List<Business> business = [];
  // List<BusinessDetail> businessOfferProductList = [];
  RxBool loading = false.obs;
  TextEditingController searchController = TextEditingController();
  ScrollController businessScroll = ScrollController();
  ScrollController offerProductScroll = ScrollController();
  RxBool itemsLoading = false.obs;
  int businessPageNumber = 1;
  int offerProductsPageNumber = 1;
  int? selectedCategory;
  int? selectedBusiness;
  String? businessName;
  BusinessDetail? businessDetail;
  List<Offer> offers = [];
  List<Event> eventsList = [];
  List<Event> allEvents = [];
  List<Event> foundEvents = [];
  DateTime currentDate2 = DateTime.now();
  String currentMonth = DateFormat.yMMMM().format(DateTime.now());
  DateTime targetDateTime = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
  MultipleMarkedDates multipleMarkedDates =
      MultipleMarkedDates(markedDates: []);
  @override
  void onInit() {
    getAllCategoriesByPagination();
    getAllEvent();
    businessScroll.addListener(businessListListener);
    offerProductScroll.addListener(offersProductListListener);
    super.onInit();
  }

  businessListListener() {
    if (business.length % 10 == 0 && itemsLoading.value == false) {
      itemsLoading.value = true;
      businessPageNumber++;
      getAllBusinessesByPagination();
    }
  }

  offersProductListListener() {
    if (offers.length % 10 == 0 && itemsLoading.value == false) {
      itemsLoading.value = true;
      offerProductsPageNumber++;
      getBusinessWithOffer();
    }
  }

  Future<void> getAllCategoriesByPagination() async {
    try {
      var resp = await _repository.getAllCategoriesByPagination();
      if (resp != null && resp['status'] == "Success") {
        categories = [];
        resp['payload'].forEach((v) {
          categories.add(Category.fromJson(v));
        });
        loading.value = false;
        update();
      } else {
        Utils.showSnackBar(
            message: "${resp['message']}", title: '', error: true);
        loading.value = false;
      }
      update();
    } catch (e) {
      loading.value = false;
      itemsLoading.value = false;
      Get.log('Save work history error of try catch : $e');
    }
  }

  Future<void> getAllBusinessesByPagination() async {
    try {
      var resp = await _repository.getAllBusinessesByPagination(
          selectedCategory, businessName, businessPageNumber, 10);
      if (resp != null && resp['status'] == "Success") {
        itemsLoading.value = false;
        resp['payload'].forEach((v) {
          business.add(Business.fromJson(v));
        });
        print(business.length);
        loading.value = false;
        update();
      } else {
        Utils.showSnackBar(
            message: "${resp['message']}", title: '', error: true);
        loading.value = false;
      }
      update();
    } catch (e) {
      loading.value = false;
      itemsLoading.value = false;
      Get.log('error of try catch : $e');
    }
  }

  Future<void> getBusinessWithOffer() async {
    try {
      var resp = await _repository.getBusinessWithOffer(
          selectedBusiness, offerProductsPageNumber, 10);
      if (resp != null && resp['status'] == "Success") {
        itemsLoading.value = false;
        businessDetail = BusinessDetail.fromJson(resp);

        resp['payload']['offer'].forEach((v) {
          offers.add(Offer.fromJson(v));
        });

        loading.value = false;
        update();
      } else {
        Utils.showSnackBar(
            message: "${resp['message']}", title: '', error: true);
        loading.value = false;
      }
      update();
    } catch (e) {
      loading.value = false;
      itemsLoading.value = false;
      Get.log('error of try catch : $e');
    }
  }

  Future<void> getAllEventByDates() async {
    eventsList = [];
    try {
      loading.value = true;
      var resp = await _repository.getAllEventByDates(startDate, endDate);
      if (resp != null && resp['status'] == "Success") {
        itemsLoading.value = false;
        resp['payload'].forEach((v) {
          eventsList.add(Event.fromJson(v));
        });
        foundEvents = eventsList;
        loading.value = false;
        update();
      } else {
        Utils.showSnackBar(
            message: "${resp['message']}", title: '', error: true);
        loading.value = false;
      }
      update();
    } catch (e) {
      loading.value = false;
      itemsLoading.value = false;
      Get.log('error of try catch : $e');
    }
  }

  Future<void> getAllEvent() async {
    eventsList = [];
    try {
      loading.value = true;
      var resp = await _repository.getAllEventByDates(startDate, endDate);
      if (resp != null && resp['status'] == "Success") {
        itemsLoading.value = false;
        resp['payload'].forEach((v) {
          allEvents.add(Event.fromJson(v));
        });
        eventsList = allEvents;
        foundEvents = allEvents;
        loading.value = false;
        update();
      } else {
        Utils.showSnackBar(
            message: "${resp['message']}", title: '', error: true);
        loading.value = false;
      }
      update();
    } catch (e) {
      loading.value = false;
      itemsLoading.value = false;
      Get.log('error of try catch : $e');
    }
  }

  void runFilter(String enteredKeyword) {
    List<Event> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = eventsList;
    } else {
      results = eventsList
          .where((event) => (event.eventName.toString())
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI

    foundEvents = results;
    update();
  }
}
