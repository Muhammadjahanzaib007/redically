import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/data/models/business_detail_model.dart';
import 'package:redically_local/data/models/business_model.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/shared/qr_scanner.dart';
import '../../../app/util/util.dart';
import '../controllers/earn_silver_controller.dart';

class OutletDetailView extends GetView<EarnSilverController> {
  const OutletDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EarnSilverController>(
      builder: (c) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: controller.businessDetail == null? Center(child: Image.asset(Utils.getImagePath('Scanner', format: 'gif'),height: 200,),) : CustomScrollView(
            controller: controller.offerProductScroll,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: AppColors.buttonColor,
                pinned: true,
                snap: false,
                floating: false,
                elevation: 0,
                title: Text(Get.arguments[0],
                    style: AppTextStyle.appBarTitle.copyWith(color: Colors.white)),
                leading: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Image.asset(
                    Utils.getIconPath("backButton"),
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.cancel_outlined,
                        size: 40,
                        color: AppColors.white,
                      )),
                  const SizedBox(
                    width: 5,
                  )
                ],
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  background:  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/Scanner.gif',
                    image: controller.businessDetail?.payload?.businessimgUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                     Text(
                        controller.businessDetail?.payload?.name?? "",
                        style: TextStyle(
                            fontSize: 28,
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        controller.businessDetail?.payload?.description ?? "",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        controller.businessDetail?.payload?.address ?? "",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        controller.businessDetail?.payload?.phoneNumber ?? "",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 50.0,
                  maxHeight: 50.0,
                  child: Container(
                    width: Get.width,
                    color: AppColors.background,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    height: 30,
                    child: ListView.builder(  
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Text(
                              "Fresh Juice",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 60.0,
                  maxHeight: 60.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    color: AppColors.background,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Popular Products",
                          style:
                              TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(QRViewExample(
                              callback: (string) {
                                print(string);
                              },
                            ));
                          },
                          child: Image.asset(
                            Utils.getIconPath("Scan"),
                            height: 35,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    Offer? offer = controller.offers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/imgplaceholder.png',
                                image: offer.offerImageUrl ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              Text(
                                offer.offerName ?? "",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                offer.offerDescription ?? "",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "\$ ${offer.offerPrice ?? ""}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    );
                  },
                  childCount: controller.offers.length,
                ),
              ),
            ],
          ),
          // ListView(
          //   children: [
          //     Image.asset(Utils.getImagePath("juiceRectangle")),
          //     Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: const [
          //           Text(
          //             "Juicito",
          //             style: TextStyle(
          //                 fontSize: 28,
          //                 color: AppColors.buttonColor,
          //                 fontWeight: FontWeight.w600),
          //           ),
          //           SizedBox(
          //             height: 8,
          //           ),
          //           Text(
          //             "Juice and Beverages",
          //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          //           ),
          //           SizedBox(
          //             height: 4,
          //           ),
          //           Text(
          //             "Civic Center, Phase 4.",
          //             style: TextStyle(fontSize: 12),
          //           ),
          //           SizedBox(
          //             height: 2,
          //           ),
          //           Text(
          //             "112-897-356",
          //             style: TextStyle(fontSize: 12),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Divider(
          //       thickness: 1,
          //       color: Colors.grey,
          //     ),
          //     Container(
          //       width: Get.width,
          //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          //       height: 30,
          //       child: ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         itemCount: 10,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Container(
          //             padding: EdgeInsets.symmetric(
          //               horizontal: 20,
          //             ),
          //             margin: EdgeInsets.symmetric(horizontal: 5),
          //             decoration: BoxDecoration(
          //                 color: AppColors.buttonColor,
          //                 borderRadius: BorderRadius.circular(50)),
          //             child: Center(
          //               child: Text(
          //                 "Fresh Juice",
          //                 style: TextStyle(color: Colors.white, fontSize: 12),
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //     const Divider(
          //       thickness: 1,
          //       color: Colors.grey,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Text(
          //             "Popular Products",
          //             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          //           ),
          //           GestureDetector(
          //             onTap: () {
          //               Get.to(QRViewExample(
          //                 callback: (string) {
          //                   print(string);
          //                 },
          //               ));
          //             },
          //             child: Image.asset(
          //               Utils.getIconPath("Scan"),
          //               height: 35,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //       child: ListView.builder(
          //           controller: ScrollController(),
          //           padding: const EdgeInsets.all(8),
          //           shrinkWrap: true,
          //           itemCount: 10,
          //           itemBuilder: (BuildContext context, int index) {
          //             return Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Container(
          //                   margin: const EdgeInsets.symmetric(vertical: 5),
          //                   height: 75,
          //                   width: 75,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage(
          //                               Utils.getImagePath("strawberryjuice"))),
          //                       borderRadius: BorderRadius.circular(15)),
          //                 ),
          //                 SizedBox(
          //                   width: 10,
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   mainAxisSize: MainAxisSize.max,
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: const [
          //                     Text(
          //                       "Strawberry",
          //                       style: TextStyle(
          //                           fontSize: 16, fontWeight: FontWeight.w500),
          //                     ),
          //                     SizedBox(
          //                       height: 3,
          //                     ),
          //                     Text(
          //                       "Fresh juice with orange \nnector",
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //                     SizedBox(
          //                       height: 3,
          //                     ),
          //                     Text(
          //                       "\$10.00",
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //                   ],
          //                 ),
          //                 Spacer(),
          //               ],
          //             );
          //           }),
          //     )
          //   ],
          // ),
        );
      }
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
