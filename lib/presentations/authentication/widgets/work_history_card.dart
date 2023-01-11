import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redically_local/app/config/app_colors.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../data/models/work_history.dart';

class WorkHistoryCard extends StatelessWidget {
  final WorkHistory workHistory;
  const WorkHistoryCard({Key? key, required this.workHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.darkGrey)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(150)),
                  child: Center(
                    child: Text(
                      workHistory.companyName ?? "N/A",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.buttonTextUnselected,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(150)),
                  child: Center(
                    child: Text(
                      workHistory.role ?? "N/A",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.buttonTextUnselected,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(150)),
            child: Center(
              child: Text(
                workHistory.startDate != null
                    ? DateFormat("dd-MMM-yyyy")
                        .format(DateTime.parse(workHistory.startDate!))
                    : "N/A",
                textAlign: TextAlign.center,
                style: AppTextStyle.buttonTextUnselected,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(150)),
            child: Center(
              child: Text(
                workHistory.address ?? "N/A",
                textAlign: TextAlign.center,
                style: AppTextStyle.buttonTextUnselected,
              ),
            ),
          )
        ],
      ),
    );
  }
}
