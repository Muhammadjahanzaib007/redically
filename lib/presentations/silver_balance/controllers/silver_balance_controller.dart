import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:redically_local/app/config/global_var.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/util/util.dart';

class SilverBalanceController extends GetxController {
  //TODO: Implement SilverBalanceController
  bool showProgress = false;
  bool showPerks = false;
  List<String> perks = [
    "Car Loan",
    "Home Loan",
    "Family Trip",
    "Medical Assistance"
  ];
  String selectedPerk = "";
  late List<bool> visible =
      List.generate(10, (index) => index < (Globals.userBalance ?? 0) ~/ 10 ? true : false);
  late Map<String, double> dataMap = {
    for (int i = 0; i < 10; i++) i.toString(): visible[i] ? 1 : 0
  };

  @override
  void onInit() {
    super.onInit();
  }

  Widget buildProgressWidget() {
    return Column(
      children: [
        Text(
          Globals.name ?? "N/A",
          style: AppTextStyle.headingShadow2,
        ),
        const SizedBox(
          height: 5,
        ),
        Stack(children: [
          AnimatedOpacity(
            opacity: showProgress ? 1 : 0,
            duration: const Duration(milliseconds: 1300),
            child: SizedBox(
              height: 210,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Balance: ${Globals.userBalance}",
                      style: AppTextStyle.headingShadow2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PieChart(
                    totalValue: 10,
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 0),
                    colorList:
                        List.generate(10, (index) => AppColors.buttonColor),
                    chartRadius: 100,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 15,
                    centerText: "${Globals.userBalance?.toInt()} %",
                    emptyColor: Colors.white,
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: false,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),

                    // gradientList: ---To add gradient colors---
                    // emptyColorGradient: ---Empty Color gradient---
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: !showProgress ? 1 : 0,
            duration: const Duration(milliseconds: 1300),
            child: SizedBox(
              height: 210,
              child: Center(
                child: NeumorphicButton(
                  onPressed: () {
                    showProgress = true;
                    update();
                  },
                  style: NeumorphicStyle(
                      color: Colors.white,
                      shape: NeumorphicShape.concave,
                      shadowDarkColor: AppColors.buttonColor,
                      shadowDarkColorEmboss: AppColors.buttonColor,
                      shadowLightColorEmboss: AppColors.buttonColor,
                      depth: 5,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(250))),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15),
                  child: const Text("My Progress"),
                ),
              ),
            ),
          ),
        ]),
        Expanded(
          child: Transform.rotate(
            angle: pi,
            child: CustomMultiChildLayout(
              delegate: PyramidDelegate(4),
              children: [
                for (var i = 0; i < 10; i++)
                  LayoutId(
                    id: i,
                    child: Transform.rotate(
                      angle: pi,
                      child: Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: showProgress
                                ? visible[i]
                                    ? 1
                                    : 0
                                : 0,
                            duration: const Duration(milliseconds: 1300),
                            child: Image.asset(
                                Utils.getImagePath("trapezoid_image")),
                          ),
                          Image.asset(Utils.getImagePath("tapezoid_frame")),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPerksForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i in perks)
          Row(
            children: [
              Radio(
                  value: selectedPerk,
                  groupValue: i,
                  onChanged: (val) {
                    selectedPerk = i;
                    update();
                  }),
              Text(
                i,
                style: AppTextStyle.regularPeta,
              ),
            ],
          )
      ],
    );
  }

  Widget getScreen() {
    return showPerks ? buildPerksForm() : buildProgressWidget();
  }
}

class PyramidDelegate extends MultiChildLayoutDelegate {
  final int sideLength;

  PyramidDelegate(this.sideLength);

  @override
  void performLayout(ui.Size size) {
    final constraints = BoxConstraints(maxWidth: (size.width - 10) / 4);
    var childId = 0;
    final rect = (Offset.zero & size).deflate((size.width + 30) / 8);
    final a = rect.topLeft;
    final b = rect.topRight;
    final c = Offset(
        rect.center.dx, rect.top + rect.width * (432 / 1050) / 2 * sqrt(3));
    for (var row = sideLength; row > 0; row--) {
      final t = 1 - (row - 1) / (sideLength - 1);
      final a1 = Offset.lerp(a, c, t);
      final b1 = Offset.lerp(b, c, t);
      for (var column = row; column > 0; column--) {
        final childSize = layoutChild(childId, constraints);
        final offset =
            row == 1 ? c : Offset.lerp(a1, b1, 1 - (column - 1) / (row - 1))!;
        positionChild(childId, offset - childSize.center(Offset.zero));
        childId++;
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
