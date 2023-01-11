import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../app/config/AppTextStyles.dart';
import '../../../app/shared/shared_widgets.dart';
import '../controllers/community_controller.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(Text('Community',
          style: AppTextStyle.appBarTitle
              .copyWith(color: const Color(0xffA5CE71)))),
      body: const Center(
        child: Text(
          'CommunityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
