import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:redically_local/app/util/util.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/authentication_controller.dart';

class WorkHistoryForm extends GetView<AuthenticationController> {
  const WorkHistoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Center(
                        child: Text(
                          "Work History",
                          style: AppTextStyle.boldTextLexendPeta,
                        ),
                      ),
                    ),
                    buildTextFeild(
                        context,
                        "Enter Company Name",
                        controller.companyController,
                        controller.companyNameNode,
                        controller: controller),
                    buildTextFeild(context, "Address",
                        controller.adressController, controller.addressNode,
                        controller: controller),
                    buildTextFeild(context, "Enter your Role",
                        controller.roleController, controller.roleNode,
                        controller: controller),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      DateTime? time;
                      return GestureDetector(
                        onTap: () {
                          controller.showDialog(
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            controller.startDate =
                                                time ?? DateTime.now();
                                            controller.update();
                                            Get.back();
                                          },
                                          child: Text("done")),
                                    ],
                                  ),
                                  Expanded(
                                    child: CupertinoDatePicker(
                                      initialDateTime: controller.startDate,
                                      maximumDate: DateTime.now()
                                          .add(const Duration(hours: 1)),
                                      mode: CupertinoDatePickerMode.date,
                                      use24hFormat: true,
                                      // This is called when the user changes the date.
                                      onDateTimeChanged: (DateTime newDate) {
                                        setState(() {
                                          time = newDate;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              context);
                        },
                        child: SizedBox(
                          width: Get.width - 200,
                          height: 90,
                          child: Container(
                            height: 90,
                            padding: EdgeInsets.all(10),
                            width: Get.width - 200,
                            decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(150)),
                            child: Center(
                              child: Text(
                                controller.startDate != null
                                    ? DateFormat("dd-MMM-yyyy")
                                        .format(controller.startDate!)
                                    : "Start Date",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.buttonTextUnselected,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    buildButton(
                      context,
                      "Next",
                      () async => await controller.saveWorkHistory(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}
