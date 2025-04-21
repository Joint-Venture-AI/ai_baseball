import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/views/features/boarding/bindings/boarding_binding.dart';
import 'package:baseball_ai/views/features/boarding/screens/boarding_screen.dart';
import 'package:baseball_ai/views/features/main_parent/bottom_nav/binding/main_parent_binding.dart';
import 'package:baseball_ai/views/features/main_parent/bottom_nav/main_parent_screen.dart';
import 'package:baseball_ai/views/features/main_parent/profile/screens/profile_screen.dart';
import 'package:baseball_ai/views/features/main_parent/progress/binding/progress_binding.dart';
import 'package:get/get.dart';

class AppPages {
  static List<GetPage> app_pages = [
    GetPage(
      name: AppRoute.boarding,
      page: () => BoardingScreen(),
      binding: BoardingBinding(),
    ),
    GetPage(
      name: AppRoute.main,
      page: () => MainParentScreen(),
      binding: MainParentBinding(),
    ),

    GetPage(
      name: AppRoute.progress,
      page: () => ProfileScreen(),
      binding: ProgressBinding(),
    ),
  ];
}
