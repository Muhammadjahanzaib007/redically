import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/app/routes/app_pages.dart';
import 'package:redically_local/app/util/util.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/config/global_var.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuController> {
  const MenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BackgroundWrapperMenu(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    color: AppColors.darkGrey,
                    size: 40,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Hero(
                        tag: "User Name",
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            Globals.name ?? "Name",
                            style: AppTextStyle.headingShadow2
                                .copyWith(decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        color: AppColors.darkGrey,
                        height: 1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Menu",
                        style: AppTextStyle.headingShadow2
                            .copyWith(decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.count(crossAxisCount: 2, children: [
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.EARN_SILVER);
                      },
                      child: Image.asset("assets/images/Earn Silver.png")),
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.SILVER_BALANCE);
                      },
                      child: Image.asset("assets/images/Silver Balance.png")),
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.FEEDBACK);
                      },
                      child: Image.asset("assets/images/Feedback.png")),
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.COMMUNITY);
                      },
                      child: Image.asset("assets/images/Community.png")),
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.MY_PROFILE);
                      },
                      child: Image.asset(Utils.getImagePath("profilebox"))),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
