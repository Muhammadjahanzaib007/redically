import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:redically_local/app/config/global_var.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/routes/app_pages.dart';
import '../../../app/shared/qr_scanner.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: GetBuilder<HomeController>(builder: (cont) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedPositioned(
                    width: cont.expandQR ? Get.width - 30 : 40,
                    top: cont.expandQR ? 150 : 0,
                    duration: const Duration(milliseconds: 1000),
                    child: InkWell(
                      onTap: () {
                        Get.to(QRViewExample(
                          callback: (string) {
                            print(string);
                          },
                        ));
                      },
                      child: Image.asset(
                        "assets/icons/Scan.png",
                      ),
                    )),
                Positioned(
                  top: 5,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: cont.expandQR ? 0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.menu_rounded,
                      size: 40,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 0,
                    child: AnimatedOpacity(
                      opacity: cont.expandQR ? 1.0 : 0,
                      duration: Duration(milliseconds: 300),
                      child: InkWell(
                        onTap: () {
                          if (cont.expandQR == true) {
                            cont.expandQR = false;
                            cont.update();
                          } else {
                            Get.toNamed(
                              Routes.MENU,
                            );
                          }
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          size: 40,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    )),
                AnimatedOpacity(
                  opacity: cont.expandQR ? 0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      "Radically Local",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.headingShadow
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: cont.expandQR ? 0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Hero(
                            tag: "User Name",
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                Globals.name ?? "N/A",
                                style: AppTextStyle.headingShadow2,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            color: AppColors.darkGrey,
                            height: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Balance:",
                                style: AppTextStyle.headingShadow2,
                              ),
                              Globals.userBalance != null ? Text(
                                "${Globals.userBalance}",
                                style: AppTextStyle.headingShadow2,
                              )  :Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: ClipRect(
                                    child: Align(
                                  heightFactor: 0.3,
                                  widthFactor: 0.7,
                                  child: Lottie.asset('assets/loader.json',
                                      height: 150),
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
