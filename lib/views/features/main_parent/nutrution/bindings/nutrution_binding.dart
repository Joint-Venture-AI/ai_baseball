import 'package:baseball_ai/views/features/main_parent/nutrution/controller/nutrution_controller.dart';
import 'package:get/get.dart';

class NutrutionBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NutrutionController());
  }
}
