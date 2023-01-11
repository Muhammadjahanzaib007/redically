import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/app/routes/app_pages.dart';
import 'package:redically_local/app/util/util.dart';
import 'package:redically_local/data/models/business_model.dart';
import 'package:redically_local/data/models/category_model.dart';
import 'package:redically_local/presentations/earn_silver/views/widgets/outlet_card.dart';
import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/earn_silver_controller.dart';

class OutletListView extends GetView<EarnSilverController> {
  const OutletListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildAppBar(Text(Get.arguments[0],
          style: AppTextStyle.appBarTitle
              .copyWith(color: const Color(0xffCF9371)))),
      body: Column(
        children: [
          SizedBox(
            height: Get.height-100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GetBuilder<EarnSilverController>(
                init: EarnSilverController(),
                builder: (context) {
                  return controller.business.isEmpty? Center(child: SizedBox(height:180,width:180,child: Image.asset(Utils.getImagePath("Scanner",format: "gif"))),) :GridView.builder(
                      controller: controller.businessScroll,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          childAspectRatio: 0.8),
                      itemCount: controller.business.length,
                      itemBuilder: (BuildContext context, int index) {
                        Business business = controller.business[index];
                        return GestureDetector(
                          child:  OutletCard(business: business,),
                          onTap: () {
                            controller.businessDetail=null;
                            controller.offerProductsPageNumber = 1;
                            controller.offers=[];
                            controller.selectedBusiness = business.id;
                            controller.getBusinessWithOffer();
                            Get.toNamed(Routes.OUTLETDETAIL,arguments: [Get.arguments[0]]);
                          },
                        );
                      });
                }
              ),
            ),
          ),
          Visibility(
            visible: controller.itemsLoading.value,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.kSecondary,
                      strokeWidth: 2,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
