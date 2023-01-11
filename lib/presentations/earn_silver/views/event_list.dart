import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/presentations/earn_silver/views/widgets/opportunity_card.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/shared/shared_widgets.dart';
import '../../../app/util/util.dart';
import '../controllers/earn_silver_controller.dart';

class EventListView extends GetView<EarnSilverController> {
  const EventListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: buildAppBar(Text('Earn Silver',
            style:
                AppTextStyle.appBarTitle.copyWith(color: Color(0xffCF9371)))),
        body: GetBuilder<EarnSilverController>(
            init: EarnSilverController(),
            builder: (controller) {
              return Column(
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
                        hintText: "Search Events",
                        icon: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset(Utils.getIconPath("searchicon")),
                        ),
                        border: InputBorder.none,
                        hintStyle: AppTextStyle.regularPeta
                            .copyWith(color: AppColors.darkGrey),
                      ),
                      onChanged: (e) {
                        controller.runFilter(e);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Upcoming Opportunities",
                      style: AppTextStyle.headingShadow2
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: controller.loading.value
                          ? Center(
                              child: Image.asset(
                                Utils.getImagePath("Scanner", format: "gif"),
                                height: 150,
                              ),
                            )
                          : controller.foundEvents.isEmpty
                              ? const Center(
                                  child: Text("No Result Found"),
                                )
                              : GridView.builder(
                                  itemCount: controller.foundEvents.length,
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
                                        event: controller.foundEvents[index],
                                      ),
                                    );
                                  }),
                    ),
                  ),
                ],
              );
            }));
  }
}
