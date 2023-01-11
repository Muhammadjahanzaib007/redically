import 'package:get/get.dart';

import 'lang/en_us.dart';

class GlobalLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {
        'en_US': enUS

      };
}