import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/marked_date.dart';
import 'package:flutter_calendar_carousel/classes/multiple_marked_dates.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redically_local/app/config/AppTextStyles.dart';
import 'package:redically_local/app/config/app_colors.dart';
import 'package:redically_local/app/routes/app_pages.dart';
import 'package:redically_local/app/shared/shared_widgets.dart';
import 'package:redically_local/app/util/util.dart';
import 'package:redically_local/data/models/category_model.dart';

import '../controllers/earn_silver_controller.dart';
import 'widgets/opportunity_card.dart';

class EarnSilverView extends GetView<EarnSilverController> {
  const EarnSilverView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: buildAppBar(Text('Earn Silver',
            style: AppTextStyle.appBarTitle
                .copyWith(color: const Color(0xffCF9371)))),
        body: GetBuilder<EarnSilverController>(
            init: EarnSilverController(),
            builder: (controller) {
              return ListView(
                children: [
                  Container(
                    height: 80,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                width: 10, color: AppColors.lightGrey),
                            vertical: BorderSide(
                                width: 15, color: AppColors.lightGrey))),
                    child: TextFormField(
                      controller: controller.searchController,
                      cursorColor: AppColors.darkGrey,
                      style: AppTextStyle.regularPeta
                          .copyWith(color: AppColors.darkGrey),
                      decoration: InputDecoration(
                        hintText: "Places to earn Silver",
                        icon: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset(Utils.getIconPath("searchicon")),
                        ),
                        border: InputBorder.none,
                        hintStyle: AppTextStyle.regularPeta
                            .copyWith(color: AppColors.darkGrey),
                      ),
                      onFieldSubmitted: (value) {
                        print(value);
                        controller.business = [];
                        controller.businessPageNumber = 1;
                        controller.businessName = value.trim();
                        controller.selectedCategory = null;
                        controller.getAllBusinessesByPagination();

                        Get.toNamed(Routes.OUTLETLIST, arguments: [value]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Browse by Category",
                      style: AppTextStyle.headingShadow2
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length + 2,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Container(
                              width: 120,
                              decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(500),
                                    bottomLeft: Radius.circular(500),
                                  )),
                            );
                          } else if (index ==
                              controller.categories.length + 1) {
                            return Container(
                              width: 120,
                              decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(500),
                                    bottomRight: Radius.circular(500),
                                  )),
                            );
                          } else {
                            Category category =
                                controller.categories[index - 1];
                            return GestureDetector(
                              onTap: () {
                                controller.business = [];
                                controller.businessPageNumber = 1;
                                controller.businessName = null;
                                controller.selectedCategory = category.id;
                                controller.getAllBusinessesByPagination();

                                Get.toNamed(Routes.OUTLETLIST,
                                    arguments: [category.name]);
                              },
                              child: Container(
                                color: AppColors.buttonColor,
                                padding: EdgeInsets.all(4),
                                child: CachedNetworkImage(
                                  imageUrl: category.imageUrl ?? "",
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 232,
                                    width: 232,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          (category.name ?? "").toUpperCase(),
                                          style: AppTextStyle.mediumPeta
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 24),
                                        )),
                                  ),
                                  placeholder: (context, url) => Container(
                                    height: 232,
                                    width: 232,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white12,
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                            child: Image.asset(
                                          Utils.getImagePath("Scanner",
                                              format: 'gif'),
                                          height: 150,
                                          width: 150,
                                        )),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              category.name ?? "",
                                              style: AppTextStyle.mediumPeta
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                            )),
                                      ],
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: 232,
                                    width: 232,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          Utils.getImagePath('no-image'),
                                        ),
                                      ),
                                    ),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          category.name ?? "",
                                          style: AppTextStyle.mediumPeta
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                        )),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Upcoming Opportunities",
                            style: AppTextStyle.headingShadow2
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.eventsList = controller.allEvents;
                            controller.foundEvents = controller.allEvents;
                            controller.update();
                            Get.toNamed(Routes.EVENTLIST);
                          },
                          child: Text(
                            "See more",
                            style:
                                AppTextStyle.regularPeta.copyWith(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child:
                    controller.allEvents.isEmpty
                        ? const Center(
                      child: Text("No Events Found"),
                    ) :
                    GridView.builder(
                        itemCount: controller.allEvents.length > 4
                            ? 4
                            : controller.allEvents.length,
                        shrinkWrap: true,
                        controller: ScrollController(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 2),
                        itemBuilder: (_, int index) {
                          return InkWell(
                            child: OpportunityCard(
                              event: controller.allEvents[index],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Filter by Dates",
                            style: AppTextStyle.headingShadow2
                                .copyWith(color: Colors.black),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.foundEvents = [];
                            controller.getAllEventByDates();
                            Get.toNamed(Routes.EVENTLIST);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonColor,
                          ),
                          child: const Text("Go"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1F1F21).withOpacity(0.92),
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 30.0,
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                controller.currentMonth,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                    color: Colors.white),
                              )),
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  controller.targetDateTime = DateTime(
                                      controller.targetDateTime.year,
                                      controller.targetDateTime.month - 1);
                                  controller.currentMonth = DateFormat.yMMMM()
                                      .format(controller.targetDateTime);
                                  controller.update();
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  controller.targetDateTime = DateTime(
                                      controller.targetDateTime.year,
                                      controller.targetDateTime.month + 1);
                                  controller.currentMonth = DateFormat.yMMMM()
                                      .format(controller.targetDateTime);
                                  controller.update();
                                },
                              )
                            ],
                          ),
                        ),
                        CalendarCarousel<Event>(
                          todayBorderColor: Colors.white54,
                          onDayPressed: (date, events) {
                            controller.currentDate2 = date;
                            if (controller.startDate == null ||
                                controller.startDate!.isAfter(date)) {
                              controller.startDate = date;
                              controller.endDate = null;
                              controller.multipleMarkedDates =
                                  MultipleMarkedDates(markedDates: []);
                            } else if (controller.endDate == null) {
                              controller.endDate = date;
                              controller.multipleMarkedDates.addRange(
                                  MarkedDate(
                                      color: Colors.white24,
                                      date: controller.startDate!),
                                  plus: controller.startDate!
                                      .difference(date)
                                      .inDays
                                      .abs());
                            } else {
                              controller.endDate = null;
                              controller.startDate = date;
                              controller.multipleMarkedDates =
                                  MultipleMarkedDates(markedDates: []);
                            }
                            controller.update();
                          },
                          weekdayTextStyle:
                              const TextStyle(color: Colors.white),
                          dayPadding: 5,
                          selectedDayButtonColor: Colors.white24,
                          selectedDayBorderColor: Colors.transparent,
                          daysHaveCircularBorder: true,
                          showOnlyCurrentMonthDate: false,
                          daysTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          weekendTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          weekFormat: false,
                          height: 300.0,
                          pageSnapping: true,
                          selectedDateTime: controller.currentDate2,
                          targetDateTime: controller.targetDateTime,
                          customGridViewPhysics: NeverScrollableScrollPhysics(),
                          markedDateCustomShapeBorder: const CircleBorder(
                              side: BorderSide(color: Colors.yellow)),
                          markedDateCustomTextStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                          showHeader: false,
                          todayTextStyle: const TextStyle(
                            color: Colors.white70,
                          ),
                          todayButtonColor: Colors.white24,
                          selectedDayTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          onCalendarChanged: (DateTime date) {
                            controller.targetDateTime = date;
                            controller.currentMonth = DateFormat.yMMMM()
                                .format(controller.targetDateTime);
                            controller.update();
                          },
                          onDayLongPressed: (DateTime date) {
                            print('long pressed date $date');
                          },
                          multipleMarkedDates: controller.multipleMarkedDates,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}
