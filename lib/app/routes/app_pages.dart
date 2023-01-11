import 'package:get/get.dart';

import '../../presentations/authentication/bindings/authentication_binding.dart';
import '../../presentations/authentication/views/authentication_view.dart';
import '../../presentations/authentication/views/sign_up_view.dart';
import '../../presentations/community/bindings/community_binding.dart';
import '../../presentations/community/views/community_view.dart';
import '../../presentations/earn_silver/bindings/earn_silver_binding.dart';
import '../../presentations/earn_silver/views/earn_silver_view.dart';
import '../../presentations/earn_silver/views/event_list.dart';
import '../../presentations/earn_silver/views/outlet_detail.dart';
import '../../presentations/earn_silver/views/outlets_list_view.dart';
import '../../presentations/feedback/bindings/feedback_binding.dart';
import '../../presentations/feedback/views/feedback_view.dart';
import '../../presentations/home/bindings/home_binding.dart';
import '../../presentations/home/views/home_view.dart';
import '../../presentations/landing/bindings/landing_binding.dart';
import '../../presentations/landing/views/landing_view.dart';
import '../../presentations/landing/widgets/triangle_image_screen.dart';
import '../../presentations/menu/bindings/menu_binding.dart';
import '../../presentations/menu/views/menu_view.dart';
import '../../presentations/my_profile/bindings/my_profile_binding.dart';
import '../../presentations/my_profile/views/my_profile_view.dart';
import '../../presentations/silver_balance/bindings/silver_balance_binding.dart';
import '../../presentations/silver_balance/views/silver_balance_view.dart';
import '../../presentations/splash/bindings/splash_binding.dart';
import '../../presentations/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.AUTHENTICATION,
        page: () => const AuthenticationView(),
        binding: AuthenticationBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.SIGN_UP,
        page: () => const SignUpView(),
        binding: AuthenticationBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
        name: _Paths.MENU,
        page: () => const MenuView(),
        binding: MenuBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.TriangleScreen,
        page: () => const TriangleImageScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.EARN_SILVER,
        page: () => const EarnSilverView(),
        binding: EarnSilverBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.SILVER_BALANCE,
        page: () => const SilverBalanceView(),
        binding: SilverBalanceBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.FEEDBACK,
        page: () => const FeedbackView(),
        binding: FeedbackBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.COMMUNITY,
        page: () => const CommunityView(),
        binding: CommunityBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.OUTLETLIST,
        page: () => const OutletListView(),
        binding: EarnSilverBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
        name: _Paths.EVENTLIST,
        page: () => const EventListView(),
        binding: EarnSilverBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 1300)),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.OUTLETDETAIL,
      page: () => const OutletDetailView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.MY_PROFILE,
      page: () => const MyProfileView(),
      binding: MyProfileBinding(),
    ),
  ];
}
