import 'package:baseball_ai/views/features/main_parent/home/sub_screens/controller/home_subscreen_controller.dart';
import 'package:get/get.dart';

class HomeSubBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeSubscreenController());
  }
}
