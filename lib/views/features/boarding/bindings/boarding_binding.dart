import 'package:baseball_ai/views/features/boarding/controllers/boarding_controller.dart';
import 'package:get/get.dart';

class BoardingBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BoardingController());
  }
}
