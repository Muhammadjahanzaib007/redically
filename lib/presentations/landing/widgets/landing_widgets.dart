import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redically_local/presentations/landing/controllers/landing_controller.dart';

class LandingWidgets {
  static Widget buildTrapezoid(
    BuildContext context,
    int ind,
    bool isleft,
    double boxheight,
    LandingController controller,
  ) {
    double hite = ((boxheight) / 6) - 10;
    double pos = (boxheight / 100 * 16 * ind) + 30;
    double? getRightPos() {
      late double positionAdjustment;
      if (ind < 4) {
        positionAdjustment = 0;
      } else if (ind < 7) {
        positionAdjustment = Get.width / 8;
      } else if (ind < 9) {
        positionAdjustment = (Get.width / 4);
      } else {
        positionAdjustment = (Get.width / 2) - Get.width / 8;
      }
      if (isleft) {
        return null;
      } else {
        if (controller.clone) {
          if (ind % 4 == 0) {
            return -25;
          } else {
            return ((((ind % 4) - 0.5) / 2) * (Get.width / 4)) -
                25 +
                positionAdjustment;
          }
        } else {
          if (controller.moveAside) {
            return Get.width - 90;
          } else {
            return ((Get.width - (hite / 0.35)) / 2);
          }
        }
      }
    }

    double? getLeftPos() {
      late double positionAdjustment;
      if (ind < 4) {
        positionAdjustment = 0;
      } else if (ind < 7) {
        positionAdjustment = Get.width / 8;
      } else if (ind < 9) {
        positionAdjustment = (Get.width / 2);
      } else {
        positionAdjustment = Get.width;
      }
      if (!isleft) {
        return null;
      } else {
        if (controller.clone) {
          if (ind % 5 == 0) {
            return 0;
          }
          return ((ind % 4) / 2) * (Get.width / 4) + positionAdjustment;
        } else {
          if (controller.moveAside) {
            return Get.width - 90;
          } else {
            return ((Get.width - (hite / 0.35)) / 2);
          }
        }
      }
    }

    late double clonePosVertical;

    if (ind < 4) {
      clonePosVertical = 0;
    } else if (ind < 7) {
      clonePosVertical = Get.width / (4 * 2.87037);
    } else if (ind < 9) {
      clonePosVertical = (Get.width / (4 * 2.87037)) * 2;
    } else {
      clonePosVertical = (Get.width / (4 * 2.87037)) * 3;
    }
    return AnimatedPositioned(
        duration: const Duration(seconds: 2),
        bottom: controller.clone
            ? clonePosVertical
            : controller.imageVisible
                ? 0
                : pos,
        height: controller.clone ? Get.width / (4 * 2.87037) : hite,
        right: getRightPos(),
        left: getLeftPos(),
        child: IgnorePointer(
          ignoring: !controller.imageVisible,
          child: InkWell(
              onTap: () async {
                if (!controller.trapezoidClicked) {
                  controller.startAnimation();
                }
              },
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: controller.imageVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      child: Image.asset(
                        "assets/images/trapezoid_image.png",
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      !isleft
                          ? "assets/images/tapezoid_frame.png"
                          : "assets/images/trapezoid_frame_left.png",
                    ),
                  ),
                ],
              )),
        ));
  }

  static Widget buildAditionalTrapezoid(BuildContext context, int ind,
      bool isleft, double boxheight, LandingController controller) {
    double hite = ((boxheight) / 6) - 10;
    double pos = boxheight / 100 * 16 * ind;
    double? getRightPos() {
      late double positionAdjustment;
      if (ind < 4) {
        positionAdjustment = 0;
      } else if (ind < 7) {
        positionAdjustment = Get.width / 8;
      } else if (ind < 9) {
        positionAdjustment = (Get.width / 4);
      } else {
        positionAdjustment = (Get.width / 2) - Get.width / 8;
      }
      if (isleft) {
        return null;
      } else {
        if (controller.clone) {
          if (ind % 4 == 0) {
            return -25;
          } else {
            return ((((ind % 4) - 0.5) / 2) * (Get.width / 4)) -
                25 +
                positionAdjustment;
          }
        } else {
          if (controller.moveAside) {
            return Get.width - 90;
          } else {
            return ((Get.width - (hite / 0.35)) / 2);
          }
        }
      }
    }

    double? getLeftPos() {
      late double positionAdjustment;
      if (ind < 4) {
        positionAdjustment = 0;
      } else if (ind < 7) {
        positionAdjustment = Get.width / 8;
      } else if (ind < 9) {
        positionAdjustment = (Get.width / 2);
      } else {
        positionAdjustment = Get.width;
      }
      if (!isleft) {
        return null;
      } else {
        if (controller.clone) {
          if (ind % 5 == 0) {
            return 0;
          }
          return ((ind % 4) / 2) * (Get.width / 4) + positionAdjustment;
        } else {
          if (controller.moveAside) {
            return Get.width - 90;
          } else {
            return ((Get.width - (hite / 0.35)) / 2);
          }
        }
      }
    }

    late double clonePosVertical;

    if (ind < 4) {
      clonePosVertical = 0;
    } else if (ind < 7) {
      clonePosVertical = Get.width / (4 * 2.87037);
    } else if (ind < 9) {
      clonePosVertical = (Get.width / (4 * 2.87037)) * 2;
    } else {
      clonePosVertical = (Get.width / (4 * 2.87037)) * 3;
    }
    return Positioned(
        bottom: clonePosVertical,
        width: Get.width / 4,
        right: getRightPos(),
        left: getLeftPos(),
        child: AnimatedOpacity(
          opacity: controller.clone ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 2000),
          child: Stack(
            children: [
              Image.asset(
                "assets/images/trapezoid_image.png",
              ),
              Container(
                color: Colors.transparent,
                child: Image.asset(
                  !isleft
                      ? "assets/images/tapezoid_frame.png"
                      : "assets/images/trapezoid_frame_left.png",
                ),
              ),
            ],
          ),
        ));
  }
}
