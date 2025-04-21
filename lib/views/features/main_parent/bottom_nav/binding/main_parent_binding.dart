import 'package:baseball_ai/views/features/main_parent/bottom_nav/controllers/main_parent_controller.dart';
import 'package:get/get.dart';

class MainParentBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MainParentController());
  }
}
