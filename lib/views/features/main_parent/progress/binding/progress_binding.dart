import 'package:baseball_ai/views/features/main_parent/progress/controller/progress_controller.dart';
import 'package:get/get.dart';

class ProgressBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ProgressController());
  }
}
