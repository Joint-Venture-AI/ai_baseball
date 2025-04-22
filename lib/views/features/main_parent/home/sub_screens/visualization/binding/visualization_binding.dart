import 'package:baseball_ai/views/features/main_parent/home/sub_screens/visualization/controller/visualization_controller.dart';
import 'package:get/get.dart';

class VisualizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisualizationController>(() => VisualizationController());
  }
}
